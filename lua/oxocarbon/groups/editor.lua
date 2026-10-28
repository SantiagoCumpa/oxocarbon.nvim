-- Grupos de la interfaz de Neovim (sin plugins)

local blend = require("oxocarbon.util").blend

---@param c oxocarbon.Colors
---@param opts oxocarbon.Config
return function(c, opts)
	local function bg_or_none(color)
		return opts.transparent and "NONE" or color
	end
	local bg = bg_or_none(c.bg)
	local float_bg = bg_or_none(c.bg_dim)
	local panel = bg_or_none(c.panel)
	-- El gutter solo tiene color propio en compat; si no, se deja sin fondo para
	-- no tapar el resaltado de CursorLine en la columna de números
	local gutter = c.gutter ~= c.bg and bg_or_none(c.gutter) or nil

	return {
		Normal = { fg = c.fg, bg = bg },
		NormalNC = { fg = c.fg, bg = bg },
		NormalFloat = { fg = c.fg, bg = float_bg },
		FloatBorder = { fg = c.bg2, bg = float_bg },
		FloatTitle = { fg = c.accent, bg = float_bg, bold = true },
		FloatFooter = { fg = c.gray2, bg = float_bg },
		Cursor = { fg = c.bg, bg = c.cursor },
		lCursor = { link = "Cursor" },
		CursorIM = { link = "Cursor" },
		TermCursor = { link = "Cursor" },
		CursorLine = { bg = c.bg1 },
		CursorColumn = { bg = c.bg1 },
		ColorColumn = { bg = c.bg1 },

		-- Gutter (editorGutter.background: distinto en compat)
		LineNr = { fg = c.gray, bg = gutter },
		LineNrAbove = { link = "LineNr" },
		LineNrBelow = { link = "LineNr" },
		CursorLineNr = { fg = c.line_nr_active, bg = gutter, bold = true },
		SignColumn = { bg = gutter or bg },
		FoldColumn = { fg = c.bg3, bg = gutter or bg },
		Folded = { fg = c.gray2, bg = c.bg1 },

		-- Paneles (statusBar/tabs/sideBar.background: distinto en compat)
		WinSeparator = { fg = c.border },
		VertSplit = { link = "WinSeparator" },
		StatusLine = { fg = c.fg_dim, bg = panel },
		StatusLineNC = { fg = c.gray2, bg = panel },
		TabLine = { fg = c.gray2, bg = panel },
		TabLineFill = { bg = panel },
		TabLineSel = { fg = c.fg, bg = bg, bold = true },
		WinBar = { fg = c.fg_dim, bg = bg },
		WinBarNC = { fg = c.gray2, bg = bg },

		Pmenu = { fg = c.fg_dim, bg = c.bg_dim },
		PmenuSel = { fg = c.white, bg = c.bg2, bold = true },
		PmenuKind = { fg = c.cyan, bg = c.bg_dim },
		PmenuKindSel = { fg = c.cyan, bg = c.bg2 },
		PmenuExtra = { fg = c.gray2, bg = c.bg_dim },
		PmenuExtraSel = { fg = c.gray2, bg = c.bg2 },
		PmenuSbar = { bg = c.bg1 },
		PmenuThumb = { bg = c.bg3 },
		PmenuMatch = { fg = c.accent, bold = true },
		PmenuMatchSel = { fg = c.accent, bold = true },

		Visual = { bg = c.bg2 },
		VisualNOS = { bg = c.bg2 },
		Search = { fg = c.white, bg = blend(c.pink, c.bg, 0.25) }, -- findMatchHighlight
		IncSearch = { fg = c.bg, bg = c.cyan }, -- findMatch
		CurSearch = { link = "IncSearch" },
		Substitute = { fg = c.bg, bg = c.pink },
		MatchParen = { fg = c.white, bg = c.bg2, bold = true },
		NonText = { fg = c.bg2 },
		Whitespace = { fg = c.bg2 },
		SpecialKey = { fg = c.bg3 },
		EndOfBuffer = { fg = c.bg },
		Conceal = { fg = c.gray },
		Directory = { fg = c.blue },
		Title = { fg = c.white, bold = true },
		ErrorMsg = { fg = c.red },
		WarningMsg = { fg = c.yellow },
		ModeMsg = { fg = c.fg_dim, bold = true },
		MoreMsg = { fg = c.teal },
		Question = { fg = c.teal },
		MsgArea = { fg = c.fg },
		QuickFixLine = { bg = c.bg2, bold = true },
		WildMenu = { link = "PmenuSel" },
		SpellBad = { sp = c.red, undercurl = true },
		SpellCap = { sp = c.yellow, undercurl = true },
		SpellLocal = { sp = c.info, undercurl = true },
		SpellRare = { sp = c.purple, undercurl = true },

		DiffAdd = { bg = blend(c.git_add, c.bg, 0.15) },
		DiffChange = { bg = blend(c.git_change, c.bg, 0.12) },
		DiffDelete = { fg = c.git_del, bg = blend(c.git_del, c.bg, 0.15) },
		DiffText = { bg = blend(c.git_change, c.bg, 0.3) },

		DiagnosticError = { fg = c.red },
		DiagnosticWarn = { fg = c.yellow },
		DiagnosticInfo = { fg = c.info },
		DiagnosticHint = { fg = c.fg_dim },
		DiagnosticOk = { fg = c.green },
		DiagnosticUnderlineError = { sp = c.red, undercurl = true },
		DiagnosticUnderlineWarn = { sp = c.yellow, undercurl = true },
		DiagnosticUnderlineInfo = { sp = c.info, undercurl = true },
		DiagnosticUnderlineHint = { sp = c.fg_dim, undercurl = true },
		DiagnosticUnderlineOk = { sp = c.green, undercurl = true },
		DiagnosticVirtualTextError = { fg = c.red, bg = blend(c.red, c.bg, 0.1) },
		DiagnosticVirtualTextWarn = { fg = c.yellow, bg = blend(c.yellow, c.bg, 0.1) },
		DiagnosticVirtualTextInfo = { fg = c.info, bg = blend(c.info, c.bg, 0.1) },
		DiagnosticVirtualTextHint = { fg = c.fg_dim, bg = c.bg_dim },
		DiagnosticUnnecessary = { fg = c.gray },
		DiagnosticDeprecated = { strikethrough = true },

		LspReferenceText = { bg = c.bg1 },
		LspReferenceRead = { bg = c.bg1 },
		LspReferenceWrite = { bg = c.bg2 },
		LspInlayHint = { fg = c.inlay_hint, bg = c.bg_dim },
		LspCodeLens = { fg = c.gray2 },
		LspSignatureActiveParameter = { fg = c.accent, bold = true },
		LspInfoBorder = { link = "FloatBorder" },
	}
end
