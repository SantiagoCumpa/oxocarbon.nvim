local M = {}

---@class oxocarbon.Integrations
---@field snacks? boolean  snacks.nvim (terminal, picker, dashboard, notifier, indent...)
---@field mini? boolean    mini.nvim (statusline, pick, files, clue, icons, diff...)
---@field lualine? boolean temas de lualine para cada variante

---@class oxocarbon.Config
---@field transparent? boolean  Sin color de fondo (usa el de la terminal)
---@field terminal_colors? boolean  Define vim.g.terminal_color_0..15
---@field integrations? oxocarbon.Integrations
---@field overrides? table<string, vim.api.keyset.highlight>|fun(colors: oxocarbon.Colors, variant: oxocarbon.Variant): table<string, vim.api.keyset.highlight>
M.defaults = {
	transparent = false,
	terminal_colors = true,
	integrations = {
		snacks = true,
		mini = true,
		lualine = true,
	},
	overrides = {},
}

---@type oxocarbon.Config
M.options = vim.deepcopy(M.defaults)

---@param opts? oxocarbon.Config
function M.set(opts)
	M.options = vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), opts or {})
end

return M
