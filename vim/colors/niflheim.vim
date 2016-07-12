" Tomorrow Night - Full Colour and 256 Colour
" http://chriskempson.com
"
" Hex colour conversion functions borrowed from the theme "Desert256""

" Default GUI colours
let s:old_foreground = "c5c8c6"
let s:foreground = "b5b59f"
let s:unfocused = "767876"
let s:background = "292b2f"
let s:selection = "373b41"
let s:line = "282a2e"
let s:red = "cc6666"
let s:orange = "de9363"
let s:yellow = "ccab66"
let s:green = "b5bd68"
let s:aqua = "8abeb7"
let s:blue = "81a2be"
let s:purple = "b294bb"
let s:window = "4d5057"

let s:function = s:foreground
let s:type = s:yellow
let s:structure = s:yellow
let s:constant = s:yellow
let s:string = s:orange
let s:comment = "7a987a"
let s:keyword = s:blue
let s:search = "fefefe"
let s:error = "454545"
" CTags specific colours
let s:ctagsfunction = s:function
let s:ctagsmember = s:aqua
" let s:ctagsmember = "81a2b1"

" Rust specific colours
let s:rustfunction = s:function
let s:rustoperator = s:foreground
let s:rusttype = s:blue
let s:rustmacro = s:blue
let s:rustmodule = s:rusttype
let s:rustmodpath = s:blue
let s:rusttrait = s:blue
let s:rustkeyword = s:purple

" Console 256 colours
if !has("gui_running")
	let s:background = ""
	let s:window = "5e5e5e"
	let s:line = "3a3a3a"
	let s:selection = "585858"
end

set background=dark
hi clear
syntax reset

let g:colors_name = "Niflheim"

if has("gui_running") || &t_Co == 88 || &t_Co == 256
	" Returns an approximate grey index for the given grey level
	fun <SID>grey_number(x)
		if &t_Co == 88
			if a:x < 23
				return 0
			elseif a:x < 69
				return 1
			elseif a:x < 103
				return 2
			elseif a:x < 127
				return 3
			elseif a:x < 150
				return 4
			elseif a:x < 173
				return 5
			elseif a:x < 196
				return 6
			elseif a:x < 219
				return 7
			elseif a:x < 243
				return 8
			else
				return 9
			endif
		else
			if a:x < 14
				return 0
			else
				let l:n = (a:x - 8) / 10
				let l:m = (a:x - 8) % 10
				if l:m < 5
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun

	" Returns the actual grey level represented by the grey index
	fun <SID>grey_level(n)
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 46
			elseif a:n == 2
				return 92
			elseif a:n == 3
				return 115
			elseif a:n == 4
				return 139
			elseif a:n == 5
				return 162
			elseif a:n == 6
				return 185
			elseif a:n == 7
				return 208
			elseif a:n == 8
				return 231
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 8 + (a:n * 10)
			endif
		endif
	endfun

	" Returns the palette index for the given grey index
	fun <SID>grey_colour(n)
		if &t_Co == 88
			if a:n == 0
				return 16
			elseif a:n == 9
				return 79
			else
				return 79 + a:n
			endif
		else
			if a:n == 0
				return 16
			elseif a:n == 25
				return 231
			else
				return 231 + a:n
			endif
		endif
	endfun

	" Returns an approximate colour index for the given colour level
	fun <SID>rgb_number(x)
		if &t_Co == 88
			if a:x < 69
				return 0
			elseif a:x < 172
				return 1
			elseif a:x < 230
				return 2
			else
				return 3
			endif
		else
			if a:x < 75
				return 0
			else
				let l:n = (a:x - 55) / 40
				let l:m = (a:x - 55) % 40
				if l:m < 20
					return l:n
				else
					return l:n + 1
				endif
			endif
		endif
	endfun

	" Returns the actual colour level for the given colour index
	fun <SID>rgb_level(n)
		if &t_Co == 88
			if a:n == 0
				return 0
			elseif a:n == 1
				return 139
			elseif a:n == 2
				return 205
			else
				return 255
			endif
		else
			if a:n == 0
				return 0
			else
				return 55 + (a:n * 40)
			endif
		endif
	endfun

	" Returns the palette index for the given R/G/B colour indices
	fun <SID>rgb_colour(x, y, z)
		if &t_Co == 88
			return 16 + (a:x * 16) + (a:y * 4) + a:z
		else
			return 16 + (a:x * 36) + (a:y * 6) + a:z
		endif
	endfun

	" Returns the palette index to approximate the given R/G/B colour levels
	fun <SID>colour(r, g, b)
		" Get the closest grey
		let l:gx = <SID>grey_number(a:r)
		let l:gy = <SID>grey_number(a:g)
		let l:gz = <SID>grey_number(a:b)

		" Get the closest colour
		let l:x = <SID>rgb_number(a:r)
		let l:y = <SID>rgb_number(a:g)
		let l:z = <SID>rgb_number(a:b)

		if l:gx == l:gy && l:gy == l:gz
			" There are two possibilities
			let l:dgr = <SID>grey_level(l:gx) - a:r
			let l:dgg = <SID>grey_level(l:gy) - a:g
			let l:dgb = <SID>grey_level(l:gz) - a:b
			let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
			let l:dr = <SID>rgb_level(l:gx) - a:r
			let l:dg = <SID>rgb_level(l:gy) - a:g
			let l:db = <SID>rgb_level(l:gz) - a:b
			let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
			if l:dgrey < l:drgb
				" Use the grey
				return <SID>grey_colour(l:gx)
			else
				" Use the colour
				return <SID>rgb_colour(l:x, l:y, l:z)
			endif
		else
			" Only one possibility
			return <SID>rgb_colour(l:x, l:y, l:z)
		endif
	endfun

	" Returns the palette index to approximate the 'rrggbb' hex string
	fun <SID>rgb(rgb)
		let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
		let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
		let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

		return <SID>colour(l:r, l:g, l:b)
	endfun

	" Sets the highlighting for the given group
	fun <SID>X(group, fg, bg, attr)
		if a:fg != ""
			exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
		endif
		if a:bg != ""
			exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
		endif
		if a:attr != ""
			exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
		endif
	endfun

	" Vim Highlighting
	call <SID>X("Normal", s:foreground, s:background, "")
	call <SID>X("LineNr", s:selection, "", "")
	call <SID>X("NonText", s:selection, "", "")
	call <SID>X("SpecialKey", s:selection, "", "")
	call <SID>X("Search", s:background, s:yellow, "")
	call <SID>X("TabLine", s:background, s:unfocused, "reverse")
	call <SID>X("TabLineFill", s:background, s:unfocused, "")
	call <SID>X("StatusLine", s:window, s:yellow, "reverse")
	call <SID>X("StatusLineNC", s:window, s:foreground, "reverse")
	call <SID>X("VertSplit", s:window, s:window, "none")
	call <SID>X("Visual", "", s:selection, "")
	call <SID>X("Directory", s:blue, "", "")
	call <SID>X("ModeMsg", s:green, "", "")
	call <SID>X("MoreMsg", s:green, "", "")
	call <SID>X("Question", s:green, "", "")
	call <SID>X("WarningMsg", s:red, "", "")
	call <SID>X("MatchParen", "", s:selection, "")
	call <SID>X("Folded", s:comment, s:background, "")
	call <SID>X("FoldColumn", "", s:background, "")
	call <SID>X("vimCommand", s:red, "", "none")
	if version >= 700
    call <SID>X("CursorLine", "", s:line, "none")
		call <SID>X("CursorColumn", "", s:line, "none")
		call <SID>X("PMenu", s:foreground, s:selection, "none")
		call <SID>X("PMenuSel", s:foreground, s:selection, "reverse")
		call <SID>X("SignColumn", "", s:background, "none")
	end
	if version >= 703
		call <SID>X("ColorColumn", "", s:line, "none")
	end

	" Standard Highlighting
	call <SID>X("Keyword", s:keyword, "", "")
	call <SID>X("Comment", s:comment, "", "")
	call <SID>X("Search", s:search, s:background, "")
	call <SID>X("Todo", s:aqua, s:background, "")
	call <SID>X("Title", s:comment, "", "")
	call <SID>X("Identifier", s:yellow, "", "none")
	call <SID>X("Statement", s:foreground, "", "")
	call <SID>X("Conditional", s:foreground, "", "")
	call <SID>X("Repeat", s:foreground, "", "")
	call <SID>X("Structure", s:structure, "", "")
	call <SID>X("Function", s:function, "", "")
	call <SID>X("Constant", s:constant, "", "")
	call <SID>X("String", s:string, "", "")
	call <SID>X("Special", s:foreground, "", "")
	call <SID>X("PreProc", s:purple, "", "")
	call <SID>X("Operator", s:aqua, "", "none")
	call <SID>X("Type", s:type, "", "none")
	call <SID>X("Define", s:purple, "", "none")
	call <SID>X("Include", s:blue, "", "")
	"call <SID>X("Ignore", "666666", "", "")

	" NERDTree Highlighting
	call <SID>X("NERDTreeDir", s:blue, "", "")

	" Syntastic Highlighting
	call <SID>X("SyntasticError", s:red, s:error, "")
	call <SID>X("SyntasticErrorSign", s:red, s:error, "")

  " CTags Highlighting
  call <SID>X("CTagsFunction", s:ctagsfunction, "", "")
  call <SID>X("CTagsMember", s:ctagsmember, "", "")
  call <SID>X("CTagsEnumeration", s:yellow, "", "")
  call <SID>X("CTagsEnumerationValue", s:yellow, "", "")
  call <SID>X("CTagsEnumerationName", s:purple, "", "")
  call <SID>X("CTagsStructure", s:structure, "", "")
  call <SID>X("CTagsType", s:red, "", "")
  call <SID>X("CTagsModule", s:rustmodule, "", "")
  call <SID>X("CTagsTrait", s:rusttrait, "", "")
  call <SID>X("CTagsTraitImplementation", s:rusttrait, "", "")
  call <SID>X("CTagsConstant", s:red, "", "")
  call <SID>X("CTagsMacro", s:purple, "", "")

  " C Highlighting
	call <SID>X("cType", s:yellow, "", "")
	call <SID>X("cOperator", s:aqua, "", "")
	call <SID>X("cStatement", s:keyword, "", "")
	call <SID>X("cString", s:string, "", "")
	call <SID>X("cStructure", s:structure, "", "")
	call <SID>X("cStorageClass", s:yellow, "", "")
	call <SID>X("cConditional", s:yellow, "", "")
	call <SID>X("cRepeat", s:yellow, "", "")

  " C++ Highlighting
	call <SID>X("cppType", s:yellow, "", "")
	call <SID>X("cppStatement", s:yellow, "", "")

  " Rust Highlighting
  call <SID>X("CTagsRustFunction", s:ctagsfunction, "", "")
  call <SID>X("CTagsRustType", s:red, "", "")
  call <SID>X("CTagsRustEnumerationName", s:purple, "", "")
  call <SID>X("CTagsRustStructure", s:blue, "", "")
  call <SID>X("CTagsRustModule", s:rustmodule, "", "")
  call <SID>X("CTagsRustConstant", s:purple, "", "")
  call <SID>X("CTagsRustTrait", s:rusttrait, "", "")
  call <SID>X("CTagsRustTraitImplementation", s:rusttrait, "", "")
  call <SID>X("CTagsRustMacro", s:purple, "", "")

  call <SID>X("rustFuncName", s:rustfunction, "", "")
	call <SID>X("rustOperator", s:rustoperator, "", "")
	call <SID>X("rustConditional", s:purple, "", "")
	call <SID>X("rustStructure", s:orange, "", "")
	call <SID>X("rustType", s:rusttype, "", "")
	call <SID>X("rustEnum", s:purple, "", "")
	call <SID>X("rustMacro", s:rustmacro, "", "")
	call <SID>X("rustSelf", s:red, "", "")
	call <SID>X("rustModPath", s:rustmodpath, "", "")
	call <SID>X("rustModPathSep", s:unfocused, "", "")
	call <SID>X("rustKeyword", s:rustkeyword, "", "")

  " PHP Highlighting
	call <SID>X("phpVarSelector", s:red, "", "")
	call <SID>X("phpKeyword", s:purple, "", "")
	call <SID>X("phpRepeat", s:purple, "", "")
	call <SID>X("phpConditional", s:purple, "", "")
	call <SID>X("phpStatement", s:purple, "", "")
	call <SID>X("phpMemberSelector", s:foreground, "", "")

	" Ruby Highlighting
	call <SID>X("rubySymbol", s:green, "", "")
	call <SID>X("rubyConstant", s:yellow, "", "")
	call <SID>X("rubyAttribute", s:blue, "", "")
	call <SID>X("rubyInclude", s:blue, "", "")
	call <SID>X("rubyLocalVariableOrMethod", s:orange, "", "")
	call <SID>X("rubyCurlyBlock", s:orange, "", "")
	call <SID>X("rubyStringDelimiter", s:green, "", "")
	call <SID>X("rubyInterpolationDelimiter", s:orange, "", "")
	call <SID>X("rubyConditional", s:purple, "", "")
	call <SID>X("rubyRepeat", s:purple, "", "")

	" Python Highlighting
	call <SID>X("pythonInclude", s:purple, "", "")
	call <SID>X("pythonStatement", s:purple, "", "")
	call <SID>X("pythonConditional", s:purple, "", "")
	call <SID>X("pythonRepeat", s:purple, "", "")
	call <SID>X("pythonException", s:purple, "", "")
	call <SID>X("pythonFunction", s:blue, "", "")

	" Go Highlighting
	call <SID>X("goStatement", s:purple, "", "")
	call <SID>X("goConditional", s:purple, "", "")
	call <SID>X("goRepeat", s:purple, "", "")
	call <SID>X("goException", s:purple, "", "")
	call <SID>X("goDeclaration", s:blue, "", "")
	call <SID>X("goConstants", s:yellow, "", "")
	call <SID>X("goBuiltins", s:orange, "", "")

	" CoffeeScript Highlighting
	call <SID>X("coffeeKeyword", s:purple, "", "")
	call <SID>X("coffeeConditional", s:purple, "", "")

	" JavaScript Highlighting
	call <SID>X("javaScriptBraces", s:foreground, "", "")
	call <SID>X("javaScriptFunction", s:purple, "", "")
	call <SID>X("javaScriptConditional", s:purple, "", "")
	call <SID>X("javaScriptRepeat", s:purple, "", "")
	call <SID>X("javaScriptNumber", s:orange, "", "")
	call <SID>X("javaScriptMember", s:orange, "", "")

	" HTML Highlighting
	call <SID>X("htmlTag", s:red, "", "")
	call <SID>X("htmlTagName", s:red, "", "")
	call <SID>X("htmlArg", s:red, "", "")
	call <SID>X("htmlScriptTag", s:red, "", "")

	" Diff Highlighting
  let s:diffbackground = "494e56"

	call <SID>X("diffAdded", s:green, "", "")
	call <SID>X("diffRemoved", s:red, "", "")
  call <SID>X("DiffAdd", s:green, s:diffbackground, "")
  call <SID>X("DiffDelete", s:red, s:diffbackground, "")
  call <SID>X("DiffChange", s:yellow, s:diffbackground, "")
  call <SID>X("DiffText", s:diffbackground, s:orange, "")

    " ShowMarks Highlighting
    call <SID>X("ShowMarksHLl", s:orange, s:background, "none")
    call <SID>X("ShowMarksHLo", s:purple, s:background, "none")
    call <SID>X("ShowMarksHLu", s:yellow, s:background, "none")
    call <SID>X("ShowMarksHLm", s:aqua, s:background, "none")

	" Delete Functions
	delf <SID>X
	delf <SID>rgb
	delf <SID>colour
	delf <SID>rgb_colour
	delf <SID>rgb_level
	delf <SID>rgb_number
	delf <SID>grey_colour
	delf <SID>grey_level
	delf <SID>grey_number
endif
