local lush = require("lush")
local hsl = require("lush.hsl")

local black_hole = {
	bg = hsl(260, 25, 5),
	bg_light = hsl(260, 25, 8),
	bg_lighter = hsl(260, 25, 11),

	header = hsl(280, 30, 65), -- Violet energy
	emphasis = hsl(200, 35, 35), -- Ionized blue
	accent = hsl(40, 90, 60), -- Radiation gold
	text = hsl(260, 15, 78),
	muted = hsl(260, 10, 50),
	subtle = hsl(260, 10, 32),
	ghost = hsl(260, 10, 10),

	error_red = hsl(355, 70, 60),
	warning_orange = hsl(35, 80, 58),
	info_blue = hsl(210, 70, 62),
	success_green = hsl(150, 55, 55),
}

---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
	local sym = injected_functions.sym

	-- ===========================================
	-- COLOR PALETTE & TYPOGRAPHIC LEVELS
	-- ===========================================

	local palette = black_hole

	-- Base colors
	local bg = palette.bg
	local bg_light = palette.bg_light
	local bg_lighter = palette.bg_lighter

	-- Typographic hierarchy (from most to least important)
	local header = palette.header
	local emphasis = palette.emphasis
	local accent = palette.accent
	local text = palette.text
	local muted = palette.muted
	local subtle = palette.subtle
	local ghost = palette.ghost

	-- Semantic colors
	local error_red = palette.error_red
	local warning_orange = palette.warning_orange
	local info_blue = palette.info_blue
	local success_green = palette.success_green
	local hint_color = palette.muted.lighten(10)

	-- Syntax-specific colors (derived from base palette)
	local string_green = accent.rotate(-30).desaturate(20)
	local number_purple = text.rotate(20).saturate(30)
	local preproc_magenta = text.rotate(-20)

	return {
		-- ===========================================
		-- UI ELEMENTS
		-- ===========================================

		-- HEADER LEVEL - Most Important UI Elements
		Title({ fg = header, gui = "bold" }),
		CursorLineNr({ fg = header, gui = "bold" }),
		MatchParen({ fg = header, bg = ghost, gui = "bold" }),
		TabLineSel({ fg = header, bg = bg, gui = "bold" }),
		FloatTitle({ fg = header, gui = "bold" }),

		-- TEXT LEVEL - Normal/Default
		Normal({ fg = text, bg = bg }),
		NormalFloat({ fg = text, bg = bg_light }),
		NormalNC({ fg = text.darken(5), bg = bg }),

		-- MUTED LEVEL - Secondary Information
		Comment({ fg = muted, gui = "italic" }),
		LineNr({ fg = muted }),
		LineNrAbove({ fg = muted }),
		LineNrBelow({ fg = muted }),
		NonText({ fg = muted }),
		SpecialKey({ fg = muted }),
		Whitespace({ fg = muted }),
		EndOfBuffer({ fg = ghost }),

		-- SUBTLE LEVEL - Borders & Separators
		VertSplit({ fg = subtle }),
		WinSeparator({ fg = subtle }),
		SignColumn({ bg = bg }),
		FoldColumn({ fg = muted, bg = bg }),
		FloatBorder({ fg = subtle }),

		-- GHOST LEVEL - Subtle Backgrounds
		CursorLine({ bg = ghost }),
		CursorColumn({ bg = ghost }),
		ColorColumn({ bg = ghost }),
		Folded({ fg = muted, bg = ghost }),

		-- ACCENT LEVEL - Highlights & Search
		Search({ fg = bg, bg = accent }),
		IncSearch({ fg = bg, bg = accent.lighten(10), gui = "bold" }),
		CurSearch({ fg = bg, bg = accent.lighten(10), gui = "bold" }),
		Substitute({ fg = bg, bg = accent.lighten(10) }),
		Visual({ bg = ghost.lighten(10) }),
		VisualNOS({ bg = ghost.lighten(10) }),

		-- INTERACTIVE STATES
		StatusLine({ fg = text, bg = bg_lighter, gui = "bold" }),
		StatusLineNC({ fg = muted, bg = bg_light }),
		TabLine({ fg = muted, bg = bg_light }),
		TabLineFill({ bg = bg }),
		WildMenu({ fg = header, bg = bg_lighter, gui = "bold" }),

		-- Popup Menu
		Pmenu({ fg = text, bg = bg_light }),
		PmenuSel({ fg = header, bg = bg_lighter, gui = "bold" }),
		PmenuKind({ fg = emphasis, bg = bg_light }),
		PmenuKindSel({ fg = emphasis, bg = bg_lighter, gui = "bold" }),
		PmenuExtra({ fg = muted, bg = bg_light }),
		PmenuExtraSel({ fg = text, bg = bg_lighter }),
		PmenuSbar({ bg = subtle }),
		PmenuThumb({ bg = muted }),

		-- Other UI
		Question({ fg = success_green }),
		MoreMsg({ fg = success_green }),
		ModeMsg({ fg = muted }),
		MsgArea({ fg = text }),
		MsgSeparator({ fg = subtle }),
		QuickFixLine({ bg = accent.darken(40) }),

		-- Window Elements
		WinBar({ fg = text, gui = "bold" }),
		WinBarNC({ fg = muted }),

		-- Terminal
		TermCursor({ gui = "reverse" }),
		TermCursorNC({ gui = "reverse" }),

		-- Cursor
		Cursor({ gui = "reverse" }),
		lCursor({ gui = "reverse" }),
		CursorIM({ gui = "reverse" }),
		CursorLineFold({ fg = muted }),
		CursorLineSign({ fg = muted }),

		-- Concealed
		Conceal({ fg = subtle }),

		-- Directory
		Directory({ fg = emphasis }),

		-- Diffs
		DiffAdd({ bg = success_green.darken(60) }),
		DiffChange({ bg = info_blue.darken(60) }),
		DiffDelete({ fg = error_red.darken(30), bg = error_red.darken(70) }),
		DiffText({ bg = info_blue.darken(50), gui = "bold" }),

		-- ===========================================
		-- SEMANTIC / DIAGNOSTIC COLORS
		-- ===========================================

		-- Errors
		Error({ fg = error_red, gui = "bold" }),
		ErrorMsg({ fg = error_red, gui = "bold" }),
		DiagnosticError({ fg = error_red }),
		DiagnosticVirtualTextError({ fg = error_red.darken(20) }),
		DiagnosticUnderlineError({ sp = error_red, gui = "undercurl" }),
		DiagnosticFloatingError({ fg = error_red }),
		DiagnosticSignError({ fg = error_red }),

		-- Warnings
		WarningMsg({ fg = warning_orange }),
		DiagnosticWarn({ fg = warning_orange }),
		DiagnosticVirtualTextWarn({ fg = warning_orange.darken(20) }),
		DiagnosticUnderlineWarn({ sp = warning_orange, gui = "undercurl" }),
		DiagnosticFloatingWarn({ fg = warning_orange }),
		DiagnosticSignWarn({ fg = warning_orange }),

		-- Info
		DiagnosticInfo({ fg = info_blue }),
		DiagnosticVirtualTextInfo({ fg = info_blue.darken(20) }),
		DiagnosticUnderlineInfo({ sp = info_blue, gui = "undercurl" }),
		DiagnosticFloatingInfo({ fg = info_blue }),
		DiagnosticSignInfo({ fg = info_blue }),

		-- Hints
		DiagnosticHint({ fg = hint_color }),
		DiagnosticVirtualTextHint({ fg = hint_color.darken(10) }),
		DiagnosticUnderlineHint({ sp = hint_color, gui = "undercurl" }),
		DiagnosticFloatingHint({ fg = hint_color }),
		DiagnosticSignHint({ fg = hint_color }),

		-- OK
		DiagnosticOk({ fg = success_green }),
		DiagnosticVirtualTextOk({ fg = success_green.darken(20) }),
		DiagnosticUnderlineOk({ sp = success_green, gui = "undercurl" }),
		DiagnosticFloatingOk({ fg = success_green }),
		DiagnosticSignOk({ fg = success_green }),

		-- Spelling
		SpellBad({ sp = error_red, gui = "undercurl" }),
		SpellCap({ sp = warning_orange, gui = "undercurl" }),
		SpellLocal({ sp = hint_color, gui = "undercurl" }),
		SpellRare({ sp = hint_color, gui = "undercurl" }),

		-- ===========================================
		-- SYNTAX HIGHLIGHTING
		-- ===========================================

		-- ACCENT LEVEL - Strings & Constants
		String({ fg = string_green }),
		Character({ fg = string_green }),

		-- TEXT LEVEL - Variables & Types
		Identifier({ fg = text }),
		Type({ fg = text.darken(20) }),
		StorageClass({ fg = text.darken(20) }),
		Structure({ fg = text.darken(20) }),
		Typedef({ fg = text.darken(20), bg = ghost }),

		-- Numbers (slightly colored)
		Number({ fg = number_purple }),
		Boolean({ fg = number_purple }),
		Float({ fg = number_purple }),
		Constant({ fg = text }),

		-- EMPHASIS LEVEL - Keywords & Control Flow
		Statement({ fg = text, bg = ghost }),
		Conditional({ fg = text, bg = ghost }),
		Repeat({ fg = text, bg = ghost }),
		Label({ fg = text, bg = ghost }),
		Keyword({ fg = emphasis }),
		Exception({ fg = text, bg = ghost }),
		Operator({ fg = muted }),

		-- EMPHASIS LEVEL - Functions
		Function({ fg = text, bg = ghost }),

		-- PREPROC LEVEL - Preprocessor
		PreProc({ fg = preproc_magenta }),
		Include({ fg = preproc_magenta }),
		Define({ fg = preproc_magenta }),
		Macro({ fg = preproc_magenta }),
		PreCondit({ fg = preproc_magenta }),

		-- SPECIAL - Special Characters
		Special({ fg = text.lighten(10) }),
		SpecialChar({ fg = text.lighten(10) }),
		Tag({ fg = emphasis }),
		Delimiter({ fg = muted.lighten(5) }),
		SpecialComment({ fg = muted.lighten(15), gui = "italic" }),
		Debug({ fg = error_red }),

		-- Other
		Underlined({ fg = info_blue, gui = "underline" }),
		Ignore({ fg = ghost }),
		Todo({ fg = accent, gui = "bold,italic" }),

		-- ===========================================
		-- LSP HIGHLIGHTS
		-- ===========================================

		LspReferenceText({ bg = ghost.lighten(5) }),
		LspReferenceRead({ bg = ghost.lighten(5) }),
		LspReferenceWrite({ bg = ghost.lighten(8) }),
		LspCodeLens({ fg = muted, gui = "italic" }),
		LspCodeLensSeparator({ fg = subtle }),
		LspSignatureActiveParameter({ fg = accent, gui = "bold" }),

		-- ===========================================
		-- TREE-SITTER SYNTAX GROUPS
		-- ===========================================

		-- Text elements
		sym("@text.literal")({ String }),
		sym("@text.reference")({ Identifier }),
		sym("@text.title")({ Title }),
		sym("@text.uri")({ Underlined }),
		sym("@text.underline")({ Underlined }),
		sym("@text.todo")({ Todo }),

		-- Comments & Documentation
		sym("@comment")({ Comment }),
		sym("@comment.documentation")({ SpecialComment }),

		-- Punctuation
		sym("@punctuation")({ Delimiter }),
		sym("@punctuation.delimiter")({ Delimiter }),
		sym("@punctuation.bracket")({ fg = text }),
		sym("@punctuation.special")({ Special }),

		-- Constants
		sym("@constant")({ Constant }),
		sym("@constant.builtin")({ Number }),
		sym("@constant.macro")({ Define }),

		-- Strings & Characters
		sym("@string")({ String }),
		sym("@string.escape")({ SpecialChar }),
		sym("@string.special")({ SpecialChar }),
		sym("@string.regex")({ fg = string_green.rotate(20) }),
		sym("@character")({ Character }),
		sym("@character.special")({ SpecialChar }),

		-- Numbers
		sym("@number")({ Number }),
		sym("@boolean")({ Boolean }),
		sym("@float")({ Float }),

		-- Functions & Methods
		sym("@function")({ Function }),
		sym("@function.builtin")({ Function }),
		sym("@function.macro")({ Macro }),
		sym("@function.call")({ Function }),
		sym("@method")({ Function }),
		sym("@method.call")({ Function }),

		-- Parameters & Variables
		sym("@parameter")({ Identifier }),
		sym("@variable")({ Identifier }),
		sym("@variable.builtin")({ fg = text.lighten(10) }),
		sym("@variable.parameter")({ Identifier }),
		sym("@variable.member")({ Identifier }),

		-- Properties & Fields
		sym("@field")({ Identifier }),
		sym("@property")({ Identifier }),

		-- Constructors
		sym("@constructor")({ Special }),

		-- Keywords & Control Flow
		sym("@keyword")({ Keyword }),
		sym("@keyword.function")({ Keyword }),
		sym("@keyword.operator")({ Operator }),
		sym("@keyword.return")({ Keyword }),
		sym("@conditional")({ Conditional }),
		sym("@repeat")({ Repeat }),
		sym("@label")({ Label }),
		sym("@operator")({ Operator }),
		sym("@exception")({ Exception }),

		-- Types
		sym("@type")({ Type }),
		sym("@type.builtin")({ Type }),
		sym("@type.definition")({ Typedef }),
		sym("@type.qualifier")({ Keyword }),

		-- Storage & Structure
		sym("@storageclass")({ StorageClass }),
		sym("@structure")({ Structure }),
		sym("@namespace")({ Identifier }),

		-- Preprocessor
		sym("@include")({ Include }),
		sym("@preproc")({ PreProc }),
		sym("@define")({ Define }),
		sym("@macro")({ Macro }),

		-- Tags & Attributes (HTML/XML/JSX)
		sym("@tag")({ Tag }),
		sym("@tag.attribute")({ Identifier }),
		sym("@tag.delimiter")({ Delimiter }),

		-- Debugging
		sym("@debug")({ Debug }),

		-- Markup (Markdown, etc.)
		sym("@markup.strong")({ gui = "bold" }),
		sym("@markup.italic")({ gui = "italic" }),
		sym("@markup.underline")({ gui = "underline" }),
		sym("@markup.strike")({ gui = "strikethrough" }),
		sym("@markup.heading")({ Title }),
		sym("@markup.link")({ fg = info_blue }),
		sym("@markup.link.url")({ Underlined }),
		sym("@markup.link.label")({ fg = emphasis }),
		sym("@markup.raw")({ String }),
		sym("@markup.list")({ fg = emphasis }),
		sym("@markup.quote")({ Comment }),

		-- Special semantic tokens
		sym("@attribute")({ PreProc }),
		sym("@module")({ Identifier }),
	}
end)

return theme

-- vi:nowrap
