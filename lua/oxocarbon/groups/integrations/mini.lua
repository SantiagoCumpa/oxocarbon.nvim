-- https://github.com/nvim-mini/mini.nvim

local blend = require("oxocarbon.util").blend

---@param c oxocarbon.Colors
---@param opts oxocarbon.Config
return function(c, opts)
	local float_bg = opts.transparent and "NONE" or c.bg_dim

	local function mode(color)
		return { fg = c.bg, bg = color, bold = true }
	end

	return {
		-- mini.icons
		MiniIconsAzure = { fg = c.sky },
		MiniIconsBlue = { fg = c.blue },
		MiniIconsCyan = { fg = c.cyan },
		MiniIconsGreen = { fg = c.green },
		MiniIconsGrey = { fg = c.fg_dim },
		MiniIconsOrange = { fg = c.orange },
		MiniIconsPurple = { fg = c.purple },
		MiniIconsRed = { fg = c.red },
		MiniIconsYellow = { fg = c.yellow },

		-- mini.statusline
		MiniStatuslineModeNormal = mode(c.pink),
		MiniStatuslineModeInsert = mode(c.cyan),
		MiniStatuslineModeVisual = mode(c.purple),
		MiniStatuslineModeReplace = mode(c.red),
		MiniStatuslineModeCommand = mode(c.blue),
		MiniStatuslineModeOther = mode(c.teal),
		MiniStatuslineDevinfo = { fg = c.fg_dim, bg = c.bg2 },
		MiniStatuslineFilename = { fg = c.fg_dim, bg = c.panel },
		MiniStatuslineFileinfo = { fg = c.fg_dim, bg = c.bg2 },
		MiniStatuslineInactive = { fg = c.gray2, bg = c.panel },

		-- mini.tabline
		MiniTablineCurrent = { fg = c.fg, bg = c.bg, bold = true },
		MiniTablineVisible = { fg = c.fg_dim, bg = c.bg_dim },
		MiniTablineHidden = { fg = c.gray2, bg = c.bg_dim },
		MiniTablineModifiedCurrent = { fg = c.yellow, bg = c.bg, bold = true },
		MiniTablineModifiedVisible = { fg = c.yellow, bg = c.bg_dim },
		MiniTablineModifiedHidden = { fg = c.yellow, bg = c.bg_dim },
		MiniTablineFill = { bg = c.panel },
		MiniTablineTabpagesection = { fg = c.bg, bg = c.accent, bold = true },
		MiniTablineTrunc = { fg = c.gray2, bg = c.bg_dim },

		-- mini.pick
		MiniPickNormal = { fg = c.fg, bg = float_bg },
		MiniPickBorder = { fg = c.bg2, bg = float_bg },
		MiniPickBorderBusy = { fg = c.yellow, bg = float_bg },
		MiniPickBorderText = { fg = c.accent, bg = float_bg, bold = true },
		MiniPickPrompt = { fg = c.fg, bg = float_bg },
		MiniPickPromptCaret = { fg = c.accent, bg = float_bg },
		MiniPickPromptPrefix = { fg = c.accent, bg = float_bg },
		MiniPickHeader = { fg = c.cyan },
		MiniPickIconDirectory = { fg = c.blue },
		MiniPickIconFile = { fg = c.fg_dim },
		MiniPickMatchCurrent = { bg = c.bg2 },
		MiniPickMatchMarked = { fg = c.yellow, bg = c.bg1 },
		MiniPickMatchRanges = { fg = c.accent, bold = true },
		MiniPickPreviewLine = { bg = c.bg2 },
		MiniPickPreviewRegion = { bg = c.bg2 },

		-- mini.files
		MiniFilesNormal = { fg = c.fg, bg = float_bg },
		MiniFilesBorder = { fg = c.bg2, bg = float_bg },
		MiniFilesBorderModified = { fg = c.yellow, bg = float_bg },
		MiniFilesCursorLine = { bg = c.bg2 },
		MiniFilesDirectory = { fg = c.blue },
		MiniFilesFile = { fg = c.fg },
		MiniFilesTitle = { fg = c.gray2, bg = float_bg },
		MiniFilesTitleFocused = { fg = c.accent, bg = float_bg, bold = true },

		-- mini.clue
		MiniClueBorder = { fg = c.bg2, bg = float_bg },
		MiniClueTitle = { fg = c.accent, bg = float_bg, bold = true },
		MiniClueDescGroup = { fg = c.accent },
		MiniClueDescSingle = { fg = c.fg_dim },
		MiniClueNextKey = { fg = c.cyan, bold = true },
		MiniClueNextKeyWithPostkeys = { fg = c.red, bold = true },
		MiniClueSeparator = { fg = c.gray2 },

		-- mini.notify
		MiniNotifyNormal = { fg = c.fg, bg = float_bg },
		MiniNotifyBorder = { fg = c.bg2, bg = float_bg },
		MiniNotifyTitle = { fg = c.accent, bg = float_bg, bold = true },
		MiniNotifyLspProgress = { fg = c.gray2, bg = float_bg },

		-- mini.starter
		MiniStarterHeader = { fg = c.accent },
		MiniStarterFooter = { fg = c.gray2 },
		MiniStarterSection = { fg = c.yellow, bold = true },
		MiniStarterItem = { fg = c.fg },
		MiniStarterItemBullet = { fg = c.bg3 },
		MiniStarterItemPrefix = { fg = c.cyan, bold = true },
		MiniStarterCurrent = { bg = c.bg1 },
		MiniStarterInactive = { fg = c.gray },
		MiniStarterQuery = { fg = c.green, bold = true },

		-- mini.diff
		MiniDiffSignAdd = { fg = c.git_add },
		MiniDiffSignChange = { fg = c.git_change },
		MiniDiffSignDelete = { fg = c.git_del },
		MiniDiffOverAdd = { bg = blend(c.git_add, c.bg, 0.15) },
		MiniDiffOverChange = { bg = blend(c.git_change, c.bg, 0.3) },
		MiniDiffOverChangeBuf = { bg = blend(c.git_change, c.bg, 0.15) },
		MiniDiffOverContext = { bg = c.bg1 },
		MiniDiffOverContextBuf = { bg = c.bg1 },
		MiniDiffOverDelete = { bg = blend(c.git_del, c.bg, 0.15) },

		-- mini.hipatterns
		MiniHipatternsTodo = { fg = c.bg, bg = c.blue, bold = true },
		MiniHipatternsNote = { fg = c.bg, bg = c.teal, bold = true },
		MiniHipatternsHack = { fg = c.bg, bg = c.yellow, bold = true },
		MiniHipatternsFixme = { fg = c.bg, bg = c.red, bold = true },

		-- mini.cursorword / indentscope / trailspace / surround / jump
		MiniCursorword = { bg = c.bg1 },
		MiniCursorwordCurrent = { bg = c.bg1 },
		MiniIndentscopeSymbol = { fg = c.bg3 },
		MiniIndentscopeSymbolOff = { fg = c.red },
		MiniTrailspace = { bg = c.red },
		MiniSurround = { fg = c.bg, bg = c.orange },
		MiniJump = { fg = c.bg, bg = c.accent },
		MiniJump2dSpot = { fg = c.orange, bold = true },
		MiniJump2dSpotAhead = { fg = c.cyan },
		MiniJump2dSpotUnique = { fg = c.yellow, bold = true },
		MiniJump2dDim = { fg = c.gray },
		MiniOperatorsExchangeFrom = { link = "IncSearch" },

		-- mini.completion / mini.map
		MiniCompletionActiveParameter = { fg = c.accent, bold = true },
		MiniCompletionInfoBorderOutdated = { fg = c.red, bg = float_bg },
		MiniMapNormal = { fg = c.gray2, bg = float_bg },
		MiniMapSymbolCount = { fg = c.cyan },
		MiniMapSymbolLine = { fg = c.accent },
		MiniMapSymbolView = { fg = c.bg3 },

		-- mini.statuscolumn: MiniStatuscolumnDim lo calcula el propio plugin a partir
		-- de LineNr y Normal en cada ColorScheme, así respeta el background
	}
end
