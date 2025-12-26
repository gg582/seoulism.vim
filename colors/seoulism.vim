" Seoulism.vim - colorscheme
" Generated from the Seoulism palette (RGB)

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
let s:palette.c1 = '#e94536'
let s:palette.c1_f = '#ad3c2b'
let s:palette.c1_i = '#ee6962'
let s:palette.c2 = '#22d2b5'
let s:palette.c2_f = '#1e9c7f'
let s:palette.c2_i = '#53dcba'
let s:palette.c3 = '#ff9f3e'
let s:palette.c3_f = '#bd6c32'
let s:palette.c3_i = '#ffc068'
let s:palette.c4 = '#2d5ce6'
let s:palette.c4_f = '#2547ab'
let s:palette.c4_i = '#5b80ec'
let s:palette.c5 = '#9c5ceb'
let s:palette.c5_f = '#8747af'
let s:palette.c5_i = '#c680ef'
let s:palette.c6 = '#2c9dd6'
let s:palette.c6_f = '#2577a0'
let s:palette.c6_i = '#5ab3df'
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
    execute 'hi DiagnosticUnderlineError gui=undercurl guisp=#ee6962'
    execute 'hi DiagnosticUnderlineWarn  gui=undercurl guisp=#ffc068'
    execute 'hi DiagnosticUnderlineInfo  gui=undercurl guisp=#5ab3df'
    execute 'hi DiagnosticUnderlineHint  gui=undercurl guisp=#53dcba'
  catch
  endtry
endif

call s:hi('Normal', '#ecece9', '#101114', '255', '233', 'NONE')
call s:hi('NormalNC', '#bebeba', '#101114', '250', '233', 'NONE')
call s:hi('Comment', '#373c44', 'NONE', '237', 'NONE', 'italic')
call s:hi('Constant', '#5ab3df', 'NONE', '74', 'NONE', 'NONE')
call s:hi('String', '#22d2b5', 'NONE', '43', 'NONE', 'NONE')
call s:hi('Character', '#53dcba', 'NONE', '79', 'NONE', 'NONE')
call s:hi('Number', '#ff9f3e', 'NONE', '215', 'NONE', 'NONE')
call s:hi('Boolean', '#ffc068', 'NONE', '215', 'NONE', 'NONE')
call s:hi('Float', '#ff9f3e', 'NONE', '215', 'NONE', 'NONE')
call s:hi('Identifier', '#ecece9', 'NONE', '255', 'NONE', 'NONE')
call s:hi('Function', '#5b80ec', 'NONE', '69', 'NONE', 'NONE')
call s:hi('Statement', '#9c5ceb', 'NONE', '135', 'NONE', 'NONE')
call s:hi('Conditional', '#9c5ceb', 'NONE', '135', 'NONE', 'NONE')
call s:hi('Repeat', '#9c5ceb', 'NONE', '135', 'NONE', 'NONE')
call s:hi('Label', '#c680ef', 'NONE', '177', 'NONE', 'NONE')
call s:hi('Operator', '#ecece9', 'NONE', '255', 'NONE', 'NONE')
call s:hi('Keyword', '#9c5ceb', 'NONE', '135', 'NONE', 'NONE')
call s:hi('Exception', '#e94536', 'NONE', '167', 'NONE', 'NONE')
call s:hi('PreProc', '#2c9dd6', 'NONE', '38', 'NONE', 'NONE')
call s:hi('Include', '#5ab3df', 'NONE', '74', 'NONE', 'NONE')
call s:hi('Define', '#2c9dd6', 'NONE', '38', 'NONE', 'NONE')
call s:hi('Macro', '#2c9dd6', 'NONE', '38', 'NONE', 'NONE')
call s:hi('PreCondit', '#2c9dd6', 'NONE', '38', 'NONE', 'NONE')
call s:hi('Type', '#2d5ce6', 'NONE', '26', 'NONE', 'NONE')
call s:hi('StorageClass', '#2d5ce6', 'NONE', '26', 'NONE', 'NONE')
call s:hi('Structure', '#2d5ce6', 'NONE', '26', 'NONE', 'NONE')
call s:hi('Typedef', '#2d5ce6', 'NONE', '26', 'NONE', 'NONE')
call s:hi('Special', '#e94536', 'NONE', '167', 'NONE', 'NONE')
call s:hi('SpecialChar', '#ffc068', 'NONE', '215', 'NONE', 'NONE')
call s:hi('Tag', '#5ab3df', 'NONE', '74', 'NONE', 'NONE')
call s:hi('Delimiter', '#464e56', 'NONE', '239', 'NONE', 'NONE')
call s:hi('SpecialComment', '#6f747b', 'NONE', '243', 'NONE', 'italic')
call s:hi('Debug', '#ee6962', 'NONE', '203', 'NONE', 'NONE')
call s:hi('Underlined', '#5ab3df', 'NONE', '74', 'NONE', 'underline')
call s:hi('Ignore', '#464e56', 'NONE', '239', 'NONE', 'NONE')
call s:hi('Error', '#ee6962', '#101114', '203', '233', 'bold')
call s:hi('Todo', '#101114', '#ff9f3e', '233', '215', 'bold')
call s:hi('CursorLine', 'NONE', '#242630', 'NONE', '235', 'NONE')
call s:hi('CursorColumn', 'NONE', '#242630', 'NONE', '235', 'NONE')
call s:hi('ColorColumn', 'NONE', '#242630', 'NONE', '235', 'NONE')
call s:hi('LineNr', '#464e56', '#101114', '239', '233', 'NONE')
call s:hi('CursorLineNr', '#ffc068', '#242630', '215', '235', 'bold')
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
call s:hi('PmenuSel', '#fffffc', '#2547ab', '231', '25', 'bold')
call s:hi('PmenuSbar', 'NONE', '#242630', 'NONE', '235', 'NONE')
call s:hi('PmenuThumb', 'NONE', '#464e56', 'NONE', '239', 'NONE')
call s:hi('Visual', 'NONE', '#2547ab', 'NONE', '25', 'NONE')
call s:hi('Search', '#101114', '#bd6c32', '233', '131', 'bold')
call s:hi('IncSearch', '#101114', '#e94536', '233', '167', 'bold')
call s:hi('MatchParen', '#fffffc', '#242630', '231', '235', 'bold')
call s:hi('Directory', '#5b80ec', 'NONE', '69', 'NONE', 'NONE')
call s:hi('Title', '#e7e7e4', 'NONE', '254', 'NONE', 'bold')
call s:hi('NonText', '#242630', '#101114', '235', '233', 'NONE')
call s:hi('Whitespace', '#242630', '#101114', '235', '233', 'NONE')
call s:hi('SpecialKey', '#242630', '#101114', '235', '233', 'NONE')
call s:hi('EndOfBuffer', '#101114', '#101114', '233', '233', 'NONE')
call s:hi('ErrorMsg', '#ee6962', '#101114', '203', '233', 'bold')
call s:hi('WarningMsg', '#ffc068', '#101114', '215', '233', 'bold')
call s:hi('MoreMsg', '#53dcba', 'NONE', '79', 'NONE', 'bold')
call s:hi('ModeMsg', '#e7e7e4', 'NONE', '254', 'NONE', 'bold')
call s:hi('Question', '#22d2b5', 'NONE', '43', 'NONE', 'bold')
call s:hi('QuickFixLine', '#101114', '#2577a0', '233', '31', 'bold')
call s:hi('DiffAdd', '#ecece9', '#1e9c7f', '255', '36', 'NONE')
call s:hi('DiffChange', '#ecece9', '#2547ab', '255', '25', 'NONE')
call s:hi('DiffDelete', '#ecece9', '#ad3c2b', '255', '130', 'NONE')
call s:hi('DiffText', '#101114', '#5b80ec', '233', '69', 'bold')
call s:hi('SpellBad', 'NONE', 'NONE', 'NONE', 'NONE', 'undercurl')
call s:hi('SpellCap', 'NONE', 'NONE', 'NONE', 'NONE', 'undercurl')
call s:hi('SpellLocal', 'NONE', 'NONE', 'NONE', 'NONE', 'undercurl')
call s:hi('SpellRare', 'NONE', 'NONE', 'NONE', 'NONE', 'undercurl')
call s:hi('DiagnosticError', '#ee6962', 'NONE', '203', 'NONE', 'NONE')
call s:hi('DiagnosticWarn', '#ffc068', 'NONE', '215', 'NONE', 'NONE')
call s:hi('DiagnosticInfo', '#5ab3df', 'NONE', '74', 'NONE', 'NONE')
call s:hi('DiagnosticHint', '#53dcba', 'NONE', '79', 'NONE', 'NONE')
call s:hi('DiagnosticOk', '#22d2b5', 'NONE', '43', 'NONE', 'NONE')
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
  let g:terminal_color_1  = '#e94536'
  let g:terminal_color_2  = '#22d2b5'
  let g:terminal_color_3  = '#ff9f3e'
  let g:terminal_color_4  = '#2d5ce6'
  let g:terminal_color_5  = '#9c5ceb'
  let g:terminal_color_6  = '#2c9dd6'
  let g:terminal_color_7  = '#e0e0dc'
  let g:terminal_color_8  = '#464e56'
  let g:terminal_color_9  = '#ee6962'
  let g:terminal_color_10 = '#53dcba'
  let g:terminal_color_11 = '#ffc068'
  let g:terminal_color_12 = '#5b80ec'
  let g:terminal_color_13 = '#c680ef'
  let g:terminal_color_14 = '#5ab3df'
  let g:terminal_color_15 = '#fffffc'
endif
