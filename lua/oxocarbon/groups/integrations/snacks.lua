-- https://github.com/folke/snacks.nvim

---@param c oxocarbon.Colors
---@param opts oxocarbon.Config
return function(c, opts)
	local float_bg = opts.transparent and "NONE" or c.bg_dim

	return {
		-- Ventanas: terminal, lazygit, lazydocker, etc. con el mismo fondo que el
		-- editor (en VSCode el panel de la terminal usa el fondo del editor)
		SnacksNormal = { link = "Normal" },
		SnacksNormalNC = { link = "Normal" },
		SnacksWinBar = { link = "WinBar" },
		SnacksWinBarNC = { link = "WinBarNC" },
		SnacksTitle = { link = "FloatTitle" },
		SnacksFooter = { link = "FloatFooter" },
		SnacksWinKey = { fg = c.cyan },
		SnacksWinKeySep = { fg = c.gray2 },
		SnacksWinKeyDesc = { fg = c.fg_dim },

		-- Picker
		SnacksPicker = { fg = c.fg, bg = float_bg },
		SnacksPickerBorder = { fg = c.bg2, bg = float_bg },
		SnacksPickerTitle = { link = "FloatTitle" },
		SnacksPickerMatch = { fg = c.accent, bold = true },
		SnacksPickerPrompt = { fg = c.accent },
		SnacksPickerDir = { fg = c.gray2 },
		SnacksPickerFile = { fg = c.fg },
		SnacksPickerSelected = { fg = c.yellow },
		SnacksPickerToggle = { fg = c.bg, bg = c.accent },
		SnacksPickerSpecial = { fg = c.cyan },
		SnacksPickerTotals = { fg = c.gray2 },
		SnacksPickerGitStatusAdded = { fg = c.git_add },
		SnacksPickerGitStatusModified = { fg = c.git_change },
		SnacksPickerGitStatusDeleted = { fg = c.git_del },
		SnacksPickerGitStatusUntracked = { fg = c.gray2 },

		-- Indent
		SnacksIndent = { fg = c.bg1 },
		SnacksIndentScope = { fg = c.bg3 },
		SnacksIndentChunk = { fg = c.bg3 },

		-- Dashboard
		SnacksDashboardHeader = { fg = c.accent },
		SnacksDashboardKey = { fg = c.cyan },
		SnacksDashboardDesc = { fg = c.fg_dim },
		SnacksDashboardIcon = { fg = c.blue },
		SnacksDashboardFooter = { fg = c.gray2 },
		SnacksDashboardSpecial = { fg = c.yellow },
		SnacksDashboardTitle = { fg = c.white, bold = true },
		SnacksDashboardFile = { fg = c.fg },
		SnacksDashboardDir = { fg = c.gray2 },

		-- Notifier
		SnacksNotifierInfo = { fg = c.info },
		SnacksNotifierIconInfo = { fg = c.info },
		SnacksNotifierTitleInfo = { fg = c.info, bold = true },
		SnacksNotifierBorderInfo = { fg = c.info },
		SnacksNotifierWarn = { fg = c.yellow },
		SnacksNotifierIconWarn = { fg = c.yellow },
		SnacksNotifierTitleWarn = { fg = c.yellow, bold = true },
		SnacksNotifierBorderWarn = { fg = c.yellow },
		SnacksNotifierError = { fg = c.red },
		SnacksNotifierIconError = { fg = c.red },
		SnacksNotifierTitleError = { fg = c.red, bold = true },
		SnacksNotifierBorderError = { fg = c.red },
		SnacksNotifierDebug = { fg = c.gray2 },
		SnacksNotifierIconDebug = { fg = c.gray2 },
		SnacksNotifierTitleDebug = { fg = c.gray2, bold = true },
		SnacksNotifierBorderDebug = { fg = c.gray2 },
		SnacksNotifierTrace = { fg = c.accent },
		SnacksNotifierIconTrace = { fg = c.accent },
		SnacksNotifierTitleTrace = { fg = c.accent, bold = true },
		SnacksNotifierBorderTrace = { fg = c.accent },

		-- Input
		SnacksInputNormal = { link = "NormalFloat" },
		SnacksInputBorder = { link = "FloatBorder" },
		SnacksInputTitle = { link = "FloatTitle" },
		SnacksInputIcon = { fg = c.accent },

		-- Otros
		SnacksStatusColumnMark = { fg = c.accent },
		SnacksZenIcon = { fg = c.accent },
	}
end
