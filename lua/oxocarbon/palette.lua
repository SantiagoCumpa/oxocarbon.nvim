-- Colores de nyoom-engineering/oxocarbon-vscode (oxocarbon.toml) y reglas de
-- cada variante tal como las aplica su generador (src/main.rs, src/ramp.rs).

local util = require("oxocarbon.util")

local M = {}

---@alias oxocarbon.Variant "default"|"compat"|"oled"|"oled-compat"|"mono"|"mono-compat"|"oled-mono"|"oled-mono-compat"|"print"

---@type oxocarbon.Variant[]
M.variants = {
	"default",
	"compat",
	"oled",
	"oled-compat",
	"mono",
	"mono-compat",
	"oled-mono",
	"oled-mono-compat",
	"print",
}

---@class oxocarbon.Flags
---@field oled boolean
---@field compat boolean
---@field mono boolean
---@field print boolean

---@param variant oxocarbon.Variant
---@return oxocarbon.Flags
function M.flags(variant)
	if variant == "print" then
		-- PRINT = OLED Monochrom invertido (make: --monochrome --oled --print)
		return { oled = true, compat = false, mono = true, print = true }
	end
	return {
		oled = variant:find("oled", 1, true) ~= nil,
		compat = variant:find("compat", 1, true) ~= nil,
		mono = variant:find("mono", 1, true) ~= nil,
		print = false,
	}
end

-- Grises IBM Carbon + acentos de Oxocarbon
M.base = {
	bg = "#161616",
	bg_dim = "#1b1b1b", -- editorSuggestWidget, flotantes
	bg1 = "#262626", -- bordes, línea del cursor, menús
	bg2 = "#393939", -- selección
	bg3 = "#525252", -- guía de indentación activa
	gray = "#6f6f6f", -- comentarios, números de línea
	gray2 = "#8d8d8d",
	gray3 = "#c6c6c6",
	fg_dim = "#dde1e6",
	fg = "#f2f4f8",
	white = "#ffffff",
	black = "#000000",

	teal = "#08bdba",
	cyan = "#3ddbd9",
	sky = "#33b1ff",
	blue = "#78a9ff",
	lightblue = "#82cfff",
	info = "#4589ff",
	focus = "#0f62fe",
	pink = "#ff7eb6",
	purple = "#be95ff",
	red = "#ee5396",
	green = "#42be65",
	yellow = "#f1c21b",
	orange = "#ff832b",

	inlay_hint = "#ada8a8", -- editorInlayHint.foreground
}

-- OLED: los grises de la UI bajan un escalón (oled_rgb en src/ramp.rs).
-- Solo afecta a la interfaz, no a la sintaxis.
M.oled_map = {
	["#161616"] = "#000000",
	["#1b1b1b"] = "#0b0b0b",
	["#1e1e1e"] = "#0b0b0b",
	["#212121"] = "#0f0f0f",
	["#262626"] = "#161616",
	["#393939"] = "#262626",
	["#525252"] = "#393939",
}

-- Monocromático: cada acento pasa al gris IBM de luminancia más cercana.
M.mono_map = {
	["#08bdba"] = "#a8a8a8",
	["#33b1ff"] = "#a8a8a8",
	["#3ddbd9"] = "#c6c6c6",
	["#42be65"] = "#a8a8a8",
	["#78a9ff"] = "#a8a8a8",
	["#82cfff"] = "#c6c6c6",
	["#a6c8ff"] = "#c6c6c6",
	["#be95ff"] = "#a8a8a8",
	["#ee5396"] = "#8d8d8d",
	["#ff7eb6"] = "#a8a8a8",
	["#0f62fe"] = "#6f6f6f",
	["#f1c21b"] = "#c6c6c6",
	["#4589ff"] = "#8d8d8d",
	["#ff832b"] = "#a8a8a8",
}

---@class oxocarbon.Colors
---@field bg string       fondo del editor
---@field bg_dim string   flotantes y menús de autocompletado
---@field panel string    barra de estado, pestañas (compat: más claro que el editor)
---@field gutter string   columna de números y signos (compat: más oscura)
---@field border string   separadores de ventanas
---@field border_strong string

--- Paleta de UI de una variante, antes de invertir (PRINT).
---@param flags oxocarbon.Flags
---@return oxocarbon.Colors
function M.ui(flags)
	local c = vim.deepcopy(M.base)

	if flags.oled then
		for k, v in pairs(c) do
			c[k] = M.oled_map[v] or v
		end
	end

	-- En VSCode la barra de estado, pestañas y paneles usan el fondo del editor
	c.panel = c.bg
	c.gutter = c.bg
	c.border = c.bg1
	c.border_strong = c.bg1

	if flags.compat then
		-- Compatibility: paneles y bordes con más contraste (COMPAT_* en src/main.rs)
		c.panel = util.midpoint(c.bg, c.bg1) -- #1e1e1e / OLED #0b0b0b
		c.gutter = flags.oled and "#030303" or "#131313"
		c.border_strong = flags.oled and "#262626" or "#393939"
		c.border = util.midpoint(flags.oled and "#161616" or "#262626", c.border_strong) -- #2f2f2f / #1e1e1e
	end

	if flags.mono then
		for k, v in pairs(c) do
			c[k] = M.mono_map[v] or v
		end
	end

	-- Colores de UI con nombre propio
	c.accent = c.pink
	c.cursor = c.white
	c.line_nr_active = c.fg_dim
	c.git_add = c.green
	c.git_change = c.teal
	c.git_del = c.red
	return c
end

--- Colores ANSI de la terminal (mismo mapeo que el tema de VSCode).
---@param c oxocarbon.Colors
function M.terminal(c)
	return {
		c.bg, c.blue, c.pink, c.green, c.teal, c.lightblue, c.sky, c.fg_dim,
		c.bg3, c.blue, c.pink, c.green, c.teal, c.lightblue, c.sky, c.white,
	}
end

return M
