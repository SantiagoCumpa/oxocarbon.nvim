local config = require("oxocarbon.config")
local palette = require("oxocarbon.palette")
local util = require("oxocarbon.util")

local M = {}

-- Integraciones que definen grupos (lualine es un tema aparte: lua/lualine/themes/)
local integrations = { "snacks", "mini" }

---@type oxocarbon.Variant?
M.current = nil

---@param variant oxocarbon.Variant
---@return string
function M.colors_name(variant)
	return variant == "default" and "oxocarbon" or ("oxocarbon-" .. variant)
end

---@param opts? oxocarbon.Config
function M.setup(opts)
	config.set(opts)
	-- Si alguna variante ya está activa, volver a aplicarla con la nueva configuración
	if M.current and vim.g.colors_name == M.colors_name(M.current) then
		vim.cmd.colorscheme(vim.g.colors_name)
	end
end

---@param variant? oxocarbon.Variant
---@return oxocarbon.Variant
local function check(variant)
	variant = variant or M.current or "default"
	if not vim.tbl_contains(palette.variants, variant) then
		vim.notify(("oxocarbon.nvim: variante desconocida %q"):format(tostring(variant)), vim.log.levels.WARN)
		return "default"
	end
	return variant
end

local function invert_groups(groups)
	for _, spec in pairs(groups) do
		for _, key in ipairs({ "fg", "bg", "sp" }) do
			if util.is_hex(spec[key]) then
				spec[key] = util.invert(spec[key])
			end
		end
	end
end

--- Colores de UI de una variante (en PRINT, ya invertidos).
---@param variant? oxocarbon.Variant  por defecto la activa
---@return oxocarbon.Colors
function M.colors(variant)
	local flags = palette.flags(check(variant))
	local c = palette.ui(flags)
	if flags.print then
		for k, v in pairs(c) do
			if util.is_hex(v) then
				c[k] = util.invert(v)
			end
		end
	end
	return c
end

--- Todos los grupos de color de una variante.
---@param variant? oxocarbon.Variant
---@return table<string, vim.api.keyset.highlight>
function M.groups(variant)
	variant = check(variant)
	local opts = config.options
	local flags = palette.flags(variant)
	local c = palette.ui(flags)
	local syntax = require("oxocarbon.groups.syntax")
	local roles = syntax.roles(c, flags)

	local groups = require("oxocarbon.groups.editor")(c, opts)
	for name, spec in pairs(syntax.groups(roles)) do
		groups[name] = spec
	end
	for _, name in ipairs(integrations) do
		if opts.integrations[name] then
			for group, spec in pairs(require("oxocarbon.groups.integrations." .. name)(c, opts)) do
				groups[group] = spec
			end
		end
	end

	-- Copias independientes: varios grupos comparten el mismo spec de rol (y
	-- vim.deepcopy sobre la tabla entera conservaría esas referencias compartidas)
	for name, spec in pairs(groups) do
		groups[name] = vim.deepcopy(spec)
	end
	if flags.print then
		invert_groups(groups)
	end

	local overrides = opts.overrides
	if type(overrides) == "function" then
		overrides = overrides(M.colors(variant), variant)
	end
	for name, spec in pairs(overrides or {}) do
		groups[name] = spec
	end
	return groups
end

--- Aplica una variante. Usar `:colorscheme oxocarbon[-variante]` (dispara los
--- eventos ColorSchemePre/ColorScheme que esperan otros plugins).
---@param variant oxocarbon.Variant
function M.load(variant)
	variant = check(variant)
	local flags = palette.flags(variant)

	-- Limpiar siempre: los plugins que calculan colores a partir del tema
	-- anterior (p. ej. MiniStatuscolumnDim) los recalculan con este
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") == 1 then
		vim.cmd("syntax reset")
	end
	vim.o.termguicolors = true
	vim.o.background = flags.print and "light" or "dark"
	M.current = variant
	vim.g.colors_name = M.colors_name(variant)

	for name, spec in pairs(M.groups(variant)) do
		vim.api.nvim_set_hl(0, name, spec)
	end

	if config.options.terminal_colors then
		for i, color in ipairs(palette.terminal(M.colors(variant))) do
			vim.g["terminal_color_" .. (i - 1)] = color
		end
	end
end

return M
