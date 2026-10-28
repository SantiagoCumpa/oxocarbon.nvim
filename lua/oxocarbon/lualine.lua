-- Tema de lualine para una variante (lo usan los archivos de lua/lualine/themes/)

---@param variant oxocarbon.Variant
return function(variant)
	local options = require("oxocarbon.config").options
	if not options.integrations.lualine then
		-- lualine "auto" captura este error y genera un tema a partir de los colores del editor
		error("oxocarbon.nvim: integración de lualine desactivada")
	end

	local c = require("oxocarbon").colors(variant)
	local panel = options.transparent and "NONE" or c.panel

	local function mode(accent)
		return {
			a = { fg = c.bg, bg = accent, gui = "bold" },
			b = { fg = c.fg_dim, bg = c.bg2 },
			c = { fg = c.gray2, bg = panel },
		}
	end

	return {
		normal = mode(c.pink),
		insert = mode(c.cyan),
		visual = mode(c.purple),
		replace = mode(c.red),
		command = mode(c.blue),
		terminal = mode(c.teal),
		inactive = {
			a = { fg = c.gray2, bg = panel, gui = "bold" },
			b = { fg = c.gray2, bg = panel },
			c = { fg = c.gray, bg = panel },
		},
	}
end
