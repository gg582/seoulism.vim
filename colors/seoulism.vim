" seoulism.vim - colorscheme
" Seoulism palette: Obangsaek anchors + cheongrok turquoise
" Mapping note: red reserved for true errors; structure keywords use calm purple to reduce visual noise.

hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'seoulism'
set background=dark

let s:palette = {}
let s:palette.bg = '#101114'
let s:palette.bg_faint = '#070709'
let s:palette.bg_intense = '#242630'
let s:palette.c0 = '#464e56'
let s:palette.c0_f = '#373c44'
let s:palette.c0_i = '#6f747b'
let s:palette.c1 = '#ea3c36'
let s:palette.c1_f = '#b43730'
let s:palette.c1_i = '#f06f67'
let s:palette.c2 = '#2bd47f'
let s:palette.c2_f = '#1f9f5f'
let s:palette.c2_i = '#63e2a7'
let s:palette.c3 = '#f6c940'
let s:palette.c3_f = '#b48932'
let s:palette.c3_i = '#ffde78'
let s:palette.c4 = '#2c5ae0'
let s:palette.c4_f = '#2242a5'
let s:palette.c4_i = '#688dee'
let s:palette.c5 = '#9c5fe8'
let s:palette.c5_f = '#8749ad'
let s:palette.c5_i = '#c582ed'
let s:palette.c6 = '#2aa394'
let s:palette.c6_f = '#1f746a'
let s:palette.c6_i = '#5bbfb0'
let s:palette.c7 = '#e0e0dc'
let s:palette.c7_f = '#a6a6a4'
let s:palette.c7_i = '#e7e7e4'
let s:palette.fg = '#ecece9'
let s:palette.fg_faint = '#bebeba'
let s:palette.fg_intense = '#fffffc'

function! s:hi(group, guifg, guibg, ctermfg, ctermbg, attr) abort
  execute 'hi' a:group
        \ 'gui=' . a:attr . ' cterm=' . a:attr
        \ 'guifg=' . a:guifg . ' guibg=' . a:guibg
        \ 'ctermfg=' . a:ctermfg . ' ctermbg=' . a:ctermbg
endfunction

" Undercurl colors (best-effort):
if has('nvim')
  try
    execute 'hi DiagnosticUnderlineError gui=undercurl guisp=#f06f67'
    execute 'hi DiagnosticUnderlineWarn  gui=undercurl guisp=#ffde78'
    execute 'hi DiagnosticUnderlineInfo  gui=undercurl guisp=#688dee'
    execute 'hi DiagnosticUnderlineHint  gui=undercurl guisp=#63e2a7'
  catch
  endtry
endif

call s:hi('Normal', '#ecece9', '#101114', '255', '233', 'NONE')
call s:hi('NormalNC', '#bebeba', '#101114', '250', '233', 'NONE')
call s:hi('Comment', '#373c44', 'NONE', '237', 'NONE', 'italic')
call s:hi('Constant', '#688dee', 'NONE', '69', 'NONE', 'NONE')
call s:hi('String', '#f6c940', 'NONE', '221', 'NONE', 'NONE')
call s:hi('Character', '#ffde78', 'NONE', '222', 'NONE', 'NONE')
call s:hi('Number', '#f6c940', 'NONE', '221', 'NONE', 'NONE')
call s:hi('Boolean', '#ffde78', 'NONE', '222', 'NONE', 'NONE')
call s:hi('Float', '#f6c940', 'NONE', '221', 'NONE', 'NONE')
call s:hi('Identifier', '#ecece9', 'NONE', '255', 'NONE', 'NONE')
call s:hi('Function', '#5bbfb0', 'NONE', '73', 'NONE', 'NONE')
call s:hi('Statement', '#8749ad', 'NONE', '97', 'NONE', 'NONE')
call s:hi('Conditional', '#8749ad', 'NONE', '97', 'NONE', 'NONE')
call s:hi('Repeat', '#8749ad', 'NONE', '97', 'NONE', 'NONE')
call s:hi('Label', '#9c5fe8', 'NONE', '134', 'NONE', 'NONE')
call s:hi('Operator', '#ecece9', 'NONE', '255', 'NONE', 'NONE')
call s:hi('Keyword', '#8749ad', 'NONE', '97', 'NONE', 'NONE')
call s:hi('Exception', '#9c5fe8', 'NONE', '134', 'NONE', 'NONE')
call s:hi('PreProc', '#688dee', 'NONE', '69', 'NONE', 'NONE')
call s:hi('Include', '#688dee', 'NONE', '69', 'NONE', 'NONE')
call s:hi('Define', '#688dee', 'NONE', '69', 'NONE', 'NONE')
call s:hi('Macro', '#688dee', 'NONE', '69', 'NONE', 'NONE')
call s:hi('PreCondit', '#688dee', 'NONE', '69', 'NONE', 'NONE')
call s:hi('Type', '#2c5ae0', 'NONE', '26', 'NONE', 'NONE')
call s:hi('StorageClass', '#2c5ae0', 'NONE', '26', 'NONE', 'NONE')
call s:hi('Structure', '#2c5ae0', 'NONE', '26', 'NONE', 'NONE')
call s:hi('Typedef', '#2c5ae0', 'NONE', '26', 'NONE', 'NONE')
call s:hi('Special', '#2aa394', 'NONE', '36', 'NONE', 'NONE')
call s:hi('SpecialChar', '#ffde78', 'NONE', '222', 'NONE', 'NONE')
call s:hi('Tag', '#688dee', 'NONE', '69', 'NONE', 'NONE')
call s:hi('Delimiter', '#464e56', 'NONE', '239', 'NONE', 'NONE')
call s:hi('SpecialComment', '#6f747b', 'NONE', '243', 'NONE', 'italic')
call s:hi('Debug', '#c582ed', 'NONE', '177', 'NONE', 'NONE')
call s:hi('Underlined', '#688dee', 'NONE', '69', 'NONE', 'underline')
call s:hi('Ignore', '#464e56', 'NONE', '239', 'NONE', 'NONE')
call s:hi('Error', '#f06f67', '#101114', '203', '233', 'bold')
call s:hi('Todo', '#101114', '#f6c940', '233', '221', 'bold')
call s:hi('CursorLine', 'NONE', '#242630', 'NONE', '235', 'NONE')
call s:hi('CursorColumn', 'NONE', '#242630', 'NONE', '235', 'NONE')
call s:hi('ColorColumn', 'NONE', '#242630', 'NONE', '235', 'NONE')
call s:hi('LineNr', '#464e56', '#101114', '239', '233', 'NONE')
call s:hi('CursorLineNr', '#ffde78', '#242630', '222', '235', 'bold')
call s:hi('SignColumn', '#464e56', '#101114', '239', '233', 'NONE')
call s:hi('FoldColumn', '#464e56', '#101114', '239', '233', 'NONE')
call s:hi('Folded', '#6f747b', '#242630', '243', '235', 'NONE')
call s:hi('VertSplit', '#242630', '#101114', '235', '233', 'NONE')
call s:hi('WinSeparator', '#242630', '#101114', '235', '233', 'NONE')
call s:hi('StatusLine', '#ecece9', '#242630', '255', '235', 'bold')
call s:hi('StatusLineNC', '#bebeba', '#070709', '250', '232', 'NONE')
call s:hi('TabLine', '#bebeba', '#070709', '250', '232', 'NONE')
call s:hi('TabLineSel', '#fffffc', '#242630', '231', '235', 'bold')
call s:hi('TabLineFill', '#bebeba', '#070709', '250', '232', 'NONE')
call s:hi('Pmenu', '#ecece9', '#242630', '255', '235', 'NONE')
call s:hi('PmenuSel', '#fffffc', '#2242a5', '231', '25', 'bold')
call s:hi('PmenuSbar', 'NONE', '#242630', 'NONE', '235', 'NONE')
call s:hi('PmenuThumb', 'NONE', '#464e56', 'NONE', '239', 'NONE')
call s:hi('Visual', 'NONE', '#2242a5', 'NONE', '25', 'NONE')
call s:hi('Search', '#101114', '#b48932', '233', '137', 'bold')
call s:hi('IncSearch', '#101114', '#9c5fe8', '233', '134', 'bold')
call s:hi('MatchParen', '#fffffc', '#242630', '231', '235', 'bold')
call s:hi('Directory', '#688dee', 'NONE', '69', 'NONE', 'NONE')
call s:hi('Title', '#e7e7e4', 'NONE', '254', 'NONE', 'bold')
call s:hi('NonText', '#242630', '#101114', '235', '233', 'NONE')
call s:hi('Whitespace', '#242630', '#101114', '235', '233', 'NONE')
call s:hi('SpecialKey', '#242630', '#101114', '235', '233', 'NONE')
call s:hi('EndOfBuffer', '#101114', '#101114', '233', '233', 'NONE')
call s:hi('ErrorMsg', '#f06f67', '#101114', '203', '233', 'bold')
call s:hi('WarningMsg', '#ffde78', '#101114', '222', '233', 'bold')
call s:hi('MoreMsg', '#63e2a7', 'NONE', '79', 'NONE', 'bold')
call s:hi('ModeMsg', '#e7e7e4', 'NONE', '254', 'NONE', 'bold')
call s:hi('Question', '#f6c940', 'NONE', '221', 'NONE', 'bold')
call s:hi('QuickFixLine', '#101114', '#1f746a', '233', '29', 'bold')
call s:hi('DiffAdd', '#ecece9', '#2242a5', '255', '25', 'NONE')
call s:hi('DiffChange', '#ecece9', '#2c5ae0', '255', '26', 'NONE')
call s:hi('DiffDelete', '#ecece9', '#b43730', '255', '131', 'NONE')
call s:hi('DiffText', '#101114', '#688dee', '233', '69', 'bold')
call s:hi('SpellBad', 'NONE', 'NONE', 'NONE', 'NONE', 'undercurl')
call s:hi('SpellCap', 'NONE', 'NONE', 'NONE', 'NONE', 'undercurl')
call s:hi('SpellLocal', 'NONE', 'NONE', 'NONE', 'NONE', 'undercurl')
call s:hi('SpellRare', 'NONE', 'NONE', 'NONE', 'NONE', 'undercurl')
call s:hi('DiagnosticError', '#f06f67', 'NONE', '203', 'NONE', 'NONE')
call s:hi('DiagnosticWarn', '#ffde78', 'NONE', '222', 'NONE', 'NONE')
call s:hi('DiagnosticInfo', '#688dee', 'NONE', '69', 'NONE', 'NONE')
call s:hi('DiagnosticHint', '#63e2a7', 'NONE', '79', 'NONE', 'NONE')
call s:hi('DiagnosticOk', '#f6c940', 'NONE', '221', 'NONE', 'NONE')
call s:hi('DiagnosticUnderlineError', 'NONE', 'NONE', 'NONE', 'NONE', 'undercurl')
call s:hi('DiagnosticUnderlineWarn', 'NONE', 'NONE', 'NONE', 'NONE', 'undercurl')
call s:hi('DiagnosticUnderlineInfo', 'NONE', 'NONE', 'NONE', 'NONE', 'undercurl')
call s:hi('DiagnosticUnderlineHint', 'NONE', 'NONE', 'NONE', 'NONE', 'undercurl')

" Treesitter links:
silent! hi! link @comment Comment
silent! hi! link @string String
silent! hi! link @string.escape SpecialChar
silent! hi! link @character Character
silent! hi! link @number Number
silent! hi! link @boolean Boolean
silent! hi! link @float Float
silent! hi! link @constant Constant
silent! hi! link @constant.builtin Constant
silent! hi! link @function Function
silent! hi! link @function.builtin Function
silent! hi! link @keyword Keyword
silent! hi! link @keyword.function Keyword
silent! hi! link @keyword.return Keyword
silent! hi! link @conditional Conditional
silent! hi! link @repeat Repeat
silent! hi! link @operator Operator
silent! hi! link @type Type
silent! hi! link @type.builtin Type
silent! hi! link @punctuation.delimiter Delimiter
silent! hi! link @punctuation.bracket Delimiter
silent! hi! link @variable Identifier
silent! hi! link @variable.builtin Identifier
silent! hi! link @property Identifier
silent! hi! link @field Identifier
silent! hi! link @parameter Identifier
silent! hi! link @tag Tag
silent! hi! link @tag.attribute Identifier
silent! hi! link @namespace Include
silent! hi! link @include Include
silent! hi! link @preproc PreProc
silent! hi! link @exception Exception
silent! hi! link @text.todo Todo

" Legacy links:
hi! link SpecialKey NonText
hi! link EndOfBuffer NonText
hi! link CursorLineSign SignColumn
hi! link CursorLineFold FoldColumn

" Neovim terminal palette:
if has('nvim')
  let g:terminal_color_0  = '#101114'
  let g:terminal_color_1  = '#9c5fe8'
  let g:terminal_color_2  = '#2bd47f'
  let g:terminal_color_3  = '#f6c940'
  let g:terminal_color_4  = '#2c5ae0'
  let g:terminal_color_5  = '#ea3c36'
  let g:terminal_color_6  = '#2aa394'
  let g:terminal_color_7  = '#e0e0dc'
  let g:terminal_color_8  = '#464e56'
  let g:terminal_color_9  = '#c582ed'
  let g:terminal_color_10 = '#63e2a7'
  let g:terminal_color_11 = '#ffde78'
  let g:terminal_color_12 = '#688dee'
  let g:terminal_color_13 = '#f06f67'
  let g:terminal_color_14 = '#5bbfb0'
  let g:terminal_color_15 = '#fffffc'
endif
