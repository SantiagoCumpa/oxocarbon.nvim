-- Sintaxis de Oxocarbon: roles de color (tokenColors / semanticTokenColors de
-- oxocarbon.toml) y su asignación a grupos de Vim, Tree-sitter y LSP.

local M = {}

---@param c oxocarbon.Colors
---@param flags oxocarbon.Flags
function M.roles(c, flags)
	local roles = {
		text = { fg = c.fg },
		comment = { fg = c.gray },
		keyword = { fg = c.blue },
		keyword_mod = { fg = c.sky },                -- storage.modifier, keyword.other
		keyword_fn = { fg = c.cyan, italic = true }, -- storage.type, keyword.other.fn
		keyword_op = { fg = c.blue },
		operator = { fg = c.cyan },
		func = { fg = c.pink, bold = true }, -- definiciones
		func_call = { fg = c.pink },
		func_builtin = { fg = c.pink },
		macro = { fg = c.pink },
		decorator = { fg = c.pink },
		string = { fg = c.purple },
		string_special = { fg = c.purple },
		regex = { fg = c.purple },
		escape = { fg = c.lightblue },
		number = { fg = c.lightblue },
		boolean = { fg = c.lightblue },
		constant = { fg = c.lightblue },
		constant_builtin = { fg = c.lightblue },
		type = { fg = c.cyan, italic = true },
		type_builtin = { fg = c.cyan, italic = true },
		namespace = { fg = c.cyan, italic = true },
		constructor = { fg = c.cyan, italic = true },
		variable = { fg = c.white },
		var_builtin = { fg = c.white },
		parameter = { fg = c.white, italic = true },
		property = { fg = c.teal },
		preproc = { fg = c.teal },
		label = { fg = c.white },
		punct = { fg = c.fg },
		delimiter = { fg = c.cyan },
		punct_special = { fg = c.cyan }, -- ${ } en templates
		tag = { fg = c.pink, bold = true },
		tag_delim = { fg = c.cyan },
		attribute = { fg = c.fg },
		md_heading = { fg = c.white, bold = true },
		md_code = { fg = c.white, bold = true },
		md_code_delim = { fg = c.teal },
		md_link = { fg = c.pink, underline = true },
		md_link_text = { fg = c.fg },
		md_quote = { fg = c.teal, italic = true },
		md_bold = { fg = c.white, bold = true },
		md_italic = { fg = c.white, italic = true },
		md_list = { fg = c.cyan },
		diff_add = { fg = c.green },
		diff_del = { fg = c.red },
		diff_change = { fg = c.sky },
		invalid = { fg = c.red },
	}

	if flags.mono then
		-- Igual que el generador de VSCode: lo que va en itálica usa #f2f4f8 y lo
		-- que va solo en negrita #ffffff
		for _, spec in pairs(roles) do
			if spec.italic then
				spec.fg = c.fg
			elseif spec.bold and not spec.underline then
				spec.fg = c.white
			end
		end
		-- Campos, llamadas a funciones y macros un tono más claro que los strings
		for _, role in ipairs({ "property", "func_call", "func_builtin", "macro" }) do
			roles[role].fg = "#c0c0c0"
		end
	end

	if flags.compat then
		-- Compatibility sube los comentarios a Gray 50 (WCAG AA)
		roles.comment.fg = "#8d8d8d"
	end

	return roles
end

---@param s table roles
function M.groups(s)
	return {
		-- Vim clásico
		Comment = s.comment,
		Constant = s.constant,
		String = s.string,
		Character = s.string,
		Number = s.number,
		Float = s.number,
		Boolean = s.boolean,
		Identifier = s.variable,
		Function = s.func,
		Statement = s.keyword,
		Conditional = s.keyword,
		Repeat = s.keyword,
		Label = s.label,
		Operator = s.operator,
		Keyword = s.keyword,
		Exception = s.keyword,
		PreProc = s.preproc,
		Include = s.keyword,
		Define = s.preproc,
		Macro = s.macro,
		PreCondit = s.preproc,
		Type = s.type,
		StorageClass = s.keyword_mod,
		Structure = s.type,
		Typedef = s.type,
		Special = s.punct_special,
		SpecialChar = s.escape,
		Tag = s.tag,
		Delimiter = s.delimiter,
		SpecialComment = s.comment,
		Debug = s.keyword,
		Underlined = { underline = true },
		Error = s.invalid,
		Todo = { fg = s.keyword.fg, bold = true },
		Added = s.diff_add,
		Changed = s.diff_change,
		Removed = s.diff_del,

		-- Tree-sitter
		["@variable"] = s.variable,
		["@variable.builtin"] = s.var_builtin,
		["@variable.parameter"] = s.parameter,
		["@variable.parameter.builtin"] = s.var_builtin,
		["@variable.member"] = s.property,
		["@property"] = s.property,
		["@constant"] = s.constant,
		["@constant.builtin"] = s.constant_builtin,
		["@constant.macro"] = s.macro,
		["@module"] = s.namespace,
		["@module.builtin"] = s.namespace,
		["@label"] = s.label,

		["@string"] = s.string,
		["@string.documentation"] = s.string,
		["@string.regexp"] = s.regex,
		["@string.escape"] = s.escape,
		["@string.special"] = s.string_special,
		["@string.special.symbol"] = s.constant,
		["@string.special.url"] = s.md_link,
		["@string.special.path"] = s.string,
		["@character"] = s.string,
		["@character.special"] = s.escape,
		["@boolean"] = s.boolean,
		["@number"] = s.number,
		["@number.float"] = s.number,

		["@type"] = s.type,
		["@type.builtin"] = s.type_builtin,
		["@type.definition"] = s.type,
		["@attribute"] = s.decorator,
		["@attribute.builtin"] = s.decorator,

		["@function"] = s.func,
		["@function.builtin"] = s.func_builtin,
		["@function.call"] = s.func_call,
		["@function.macro"] = s.macro,
		["@function.method"] = s.func,
		["@function.method.call"] = s.func_call,
		["@constructor"] = s.constructor,
		["@operator"] = s.operator,

		["@keyword"] = s.keyword,
		["@keyword.coroutine"] = s.keyword,
		["@keyword.function"] = s.keyword_fn,
		["@keyword.operator"] = s.keyword_op,
		["@keyword.import"] = s.keyword,
		["@keyword.type"] = s.keyword_fn,
		["@keyword.modifier"] = s.keyword_mod,
		["@keyword.repeat"] = s.keyword,
		["@keyword.return"] = s.keyword,
		["@keyword.debug"] = s.keyword,
		["@keyword.exception"] = s.keyword,
		["@keyword.conditional"] = s.keyword,
		["@keyword.conditional.ternary"] = s.operator,
		["@keyword.directive"] = s.preproc,
		["@keyword.directive.define"] = s.preproc,

		["@punctuation.delimiter"] = s.delimiter,
		["@punctuation.bracket"] = s.punct,
		["@punctuation.special"] = s.punct_special,

		["@comment"] = s.comment,
		["@comment.documentation"] = s.comment,

		["@tag"] = s.tag,
		["@tag.builtin"] = s.tag,
		["@tag.attribute"] = s.attribute,
		["@tag.delimiter"] = s.tag_delim,

		["@markup.strong"] = s.md_bold,
		["@markup.italic"] = s.md_italic,
		["@markup.strikethrough"] = { strikethrough = true },
		["@markup.underline"] = { underline = true },
		["@markup.heading"] = s.md_heading,
		["@markup.quote"] = s.md_quote,
		["@markup.math"] = s.string_special,
		["@markup.link"] = s.md_link_text,
		["@markup.link.label"] = s.md_link_text,
		["@markup.link.url"] = s.md_link,
		["@markup.raw"] = s.md_code,
		["@markup.raw.block"] = s.text,
		["@markup.raw.delimiter"] = s.md_code_delim,
		["@markup.list"] = s.md_list,
		["@markup.list.checked"] = s.diff_add,
		["@markup.list.unchecked"] = s.md_list,

		["@diff.plus"] = s.diff_add,
		["@diff.minus"] = s.diff_del,
		["@diff.delta"] = s.diff_change,

		-- LSP semantic tokens
		["@lsp.type.class"] = s.type,
		["@lsp.type.interface"] = s.type,
		["@lsp.type.struct"] = s.type,
		["@lsp.type.enum"] = s.type,
		["@lsp.type.type"] = s.type,
		["@lsp.type.typeParameter"] = s.type,
		["@lsp.type.builtinType"] = s.type_builtin,
		["@lsp.type.namespace"] = s.namespace,
		["@lsp.type.function"] = s.func_call,
		["@lsp.type.method"] = s.func_call,
		["@lsp.type.macro"] = s.macro,
		["@lsp.type.decorator"] = s.decorator,
		["@lsp.type.parameter"] = s.parameter,
		["@lsp.type.property"] = s.property,
		["@lsp.type.enumMember"] = s.constant,
		["@lsp.type.event"] = s.property,
		["@lsp.type.modifier"] = s.keyword_mod,
		["@lsp.type.selfKeyword"] = s.var_builtin,
		["@lsp.type.selfParameter"] = s.var_builtin,
		["@lsp.typemod.function.declaration"] = s.func,
		["@lsp.typemod.method.declaration"] = s.func,
		["@lsp.typemod.function.defaultLibrary"] = s.func_builtin,
		["@lsp.typemod.variable.defaultLibrary"] = s.var_builtin,
		["@lsp.mod.deprecated"] = { strikethrough = true },
	}
end

return M
