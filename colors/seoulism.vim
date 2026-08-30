" seoulism.vim - colorscheme
" Systemic dark theme based on cardinal color hierarchy.

hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'seoulism'
set background=dark

" Configuration
let g:seoulism_rigorous = get(g:, 'seoulism_rigorous', 0)
let g:seoulism_italic = get(g:, 'seoulism_italic', 1)

" =============================================================================
" Palette
" =============================================================================
let s:p = {}
let s:p.bg           = '#111116'
let s:p.bg_sub       = '#07070a'
let s:p.bg_alt       = '#1a1a22'
let s:p.bg_sel       = '#2f4fa3'

let s:p.fg           = '#b6b5a8'
let s:p.fg_sub       = '#d7d6d2'
let s:p.fg_bright    = '#efeeea'

let s:p.vermilion    = '#e05a55'
let s:p.jade         = '#3aa39a'
let s:p.emerald      = '#35a06f'
let s:p.ochre        = '#e5c15a'
let s:p.royal_blue   = '#3f6bd9'
let s:p.muted_blue   = '#7f85ac'
let s:p.charcoal     = '#5f6770'
let s:p.gold         = '#f0d487'
let s:p.sky          = '#6f8ee6'

let s:italic = g:seoulism_italic ? 'italic' : 'NONE'

function! s:hi(group, guifg, guibg, ctermfg, ctermbg, attr) abort
  execute 'hi' a:group
        \ 'gui=' . a:attr . ' cterm=' . a:attr
        \ 'guifg=' . a:guifg . ' guibg=' . a:guibg
        \ 'ctermfg=' . a:ctermfg . ' ctermbg=' . a:ctermbg
endfunction

" =============================================================================
" Core Syntax
" =============================================================================
call s:hi('Normal', s:p.fg, s:p.bg, '255', '233', 'NONE')
call s:hi('NormalNC', s:p.fg_sub, s:p.bg, '250', '233', 'NONE')
call s:hi('Comment', s:p.muted_blue, 'NONE', '103', 'NONE', s:italic)
call s:hi('Constant', s:p.sky, 'NONE', '69', 'NONE', 'NONE')
call s:hi('String', s:p.ochre, 'NONE', '221', 'NONE', 'NONE')
call s:hi('Character', s:p.gold, 'NONE', '222', 'NONE', 'NONE')
call s:hi('Number', s:p.ochre, 'NONE', '221', 'NONE', 'NONE')
call s:hi('Boolean', s:p.gold, 'NONE', '222', 'NONE', 'NONE')
call s:hi('Float', s:p.ochre, 'NONE', '221', 'NONE', 'NONE')
call s:hi('Identifier', s:p.fg, 'NONE', '255', 'NONE', 'NONE')
call s:hi('Function', '#6bc0b6', 'NONE', '73', 'NONE', 'NONE')

call s:hi('Statement', s:p.vermilion, 'NONE', '167', 'NONE', 'bold')
call s:hi('Conditional', s:p.vermilion, 'NONE', '167', 'NONE', 'bold')
call s:hi('Repeat', s:p.vermilion, 'NONE', '167', 'NONE', 'bold')
call s:hi('Keyword', s:p.vermilion, 'NONE', '167', 'NONE', 'bold')
call s:hi('Label', s:p.vermilion, 'NONE', '167', 'NONE', 'NONE')
call s:hi('Exception', '#e77e79', 'NONE', '203', 'NONE', 'bold')

call s:hi('Operator', s:p.fg, 'NONE', '255', 'NONE', 'NONE')
call s:hi('PreProc', s:p.sky, 'NONE', '69', 'NONE', 'NONE')
call s:hi('Include', s:p.sky, 'NONE', '69', 'NONE', 'NONE')
call s:hi('Define', s:p.sky, 'NONE', '69', 'NONE', 'NONE')
call s:hi('Macro', s:p.sky, 'NONE', '69', 'NONE', 'NONE')
call s:hi('PreCondit', s:p.sky, 'NONE', '69', 'NONE', 'NONE')
call s:hi('Type', s:p.fg_bright, 'NONE', '231', 'NONE', s:italic)
call s:hi('StorageClass', s:p.fg_bright, 'NONE', '231', 'NONE', s:italic)
call s:hi('Structure', s:p.fg_bright, 'NONE', '231', 'NONE', s:italic)
call s:hi('Typedef', s:p.fg_bright, 'NONE', '231', 'NONE', s:italic)
call s:hi('Special', s:p.jade, 'NONE', '36', 'NONE', 'NONE')
call s:hi('Delimiter', s:p.charcoal, 'NONE', '239', 'NONE', 'NONE')
call s:hi('Underlined', 'NONE', 'NONE', 'NONE', 'NONE', 'underline')
call s:hi('Ignore', 'NONE', 'NONE', 'NONE', 'NONE', 'NONE')
call s:hi('Error', '#e77e79', s:p.bg, '203', '233', 'bold')
call s:hi('Todo', s:p.bg, s:p.ochre, '233', '221', 'bold')

" =============================================================================
" Editor UI
" =============================================================================
call s:hi('Cursor', s:p.bg, s:p.fg, '233', '255', 'NONE')
call s:hi('CursorLine', 'NONE', '#2b2e36', 'NONE', '235', 'NONE')
call s:hi('LineNr', s:p.charcoal, s:p.bg, '239', '233', 'NONE')
call s:hi('CursorLineNr', s:p.gold, '#2b2e36', '222', '235', 'bold')
call s:hi('StatusLine', s:p.fg, '#2b2e36', '255', '235', 'bold')
call s:hi('StatusLineNC', s:p.fg_sub, '#121318', '250', '232', 'NONE')
call s:hi('StatusLineTerm', s:p.fg_bright, '#2b2e36', '231', '235', 'bold')
call s:hi('StatusLineTermNC', s:p.fg_sub, '#121318', '250', '232', 'NONE')
call s:hi('WinBar', s:p.fg_bright, '#2b2e36', '231', '235', 'bold')
call s:hi('WinBarNC', s:p.fg_sub, '#121318', '250', '232', 'NONE')
call s:hi('TabLine', s:p.fg_sub, '#2b2e36', '250', '235', 'NONE')
call s:hi('TabLineSel', s:p.bg, s:p.jade, '233', '36', 'bold')
call s:hi('TabLineFill', s:p.charcoal, '#121318', '239', '232', 'NONE')
call s:hi('WildMenu', s:p.bg, s:p.ochre, '233', '221', 'bold')
call s:hi('VertSplit', '#121318', '#121318', '232', '232', 'NONE')
call s:hi('Pmenu', s:p.fg, '#2b2e36', '255', '235', 'NONE')
call s:hi('PmenuSel', s:p.fg_bright, s:p.bg_sel, '231', '25', 'bold')
call s:hi('PmenuSbar', 'NONE', s:p.bg_alt, 'NONE', '234', 'NONE')
call s:hi('PmenuThumb', 'NONE', s:p.charcoal, 'NONE', '239', 'NONE')
call s:hi('Visual', 'NONE', s:p.bg_sel, 'NONE', '25', 'NONE')
call s:hi('Search', s:p.bg, '#b29245', '233', '137', 'bold')
call s:hi('IncSearch', s:p.bg, s:p.ochre, '233', '221', 'NONE')
call s:hi('NonText', s:p.charcoal, 'NONE', '239', 'NONE', 'NONE')
call s:hi('Folded', s:p.muted_blue, s:p.bg_alt, '103', '234', s:italic)
call s:hi('FoldColumn', s:p.charcoal, s:p.bg, '239', '233', 'NONE')
call s:hi('ColorColumn', 'NONE', s:p.bg_alt, 'NONE', '234', 'NONE')
call s:hi('MatchParen', s:p.fg_bright, s:p.charcoal, '231', '239', 'bold')
call s:hi('Directory', s:p.sky, 'NONE', '69', 'NONE', 'NONE')
call s:hi('Title', s:p.vermilion, 'NONE', '167', 'NONE', 'bold')
call s:hi('MoreMsg', s:p.vermilion, 'NONE', '167', 'NONE', 'bold')
call s:hi('ModeMsg', s:p.vermilion, 'NONE', '167', 'NONE', 'bold')
call s:hi('Question', s:p.vermilion, 'NONE', '167', 'NONE', 'bold')
call s:hi('WarningMsg', s:p.ochre, 'NONE', '221', 'NONE', 'bold')
call s:hi('ErrorMsg', '#e77e79', s:p.bg, '203', '233', 'bold')

" Statusline segment slots used by Vim's %1*..%9* syntax and lightweight
" statusline plugins. These also give integrations such as vim-go a palette
" when their status text is embedded in a custom bottom bar.
call s:hi('User1', s:p.bg, s:p.vermilion, '233', '167', 'bold')
call s:hi('User2', s:p.fg_bright, '#2b2e36', '231', '235', 'NONE')
call s:hi('User3', s:p.fg_sub, '#121318', '250', '232', 'NONE')
call s:hi('User4', s:p.bg, s:p.ochre, '233', '221', 'bold')
call s:hi('User5', s:p.bg, '#e77e79', '233', '203', 'bold')
call s:hi('User6', s:p.bg, s:p.emerald, '233', '35', 'bold')
call s:hi('User7', s:p.bg, s:p.sky, '233', '69', 'bold')
call s:hi('User8', s:p.bg, s:p.vermilion, '233', '167', 'bold')
call s:hi('User9', s:p.charcoal, s:p.bg_sub, '239', '232', 'NONE')

" Compatibility names used by small statusline/tabline plugins and user
" configs. Unknown highlight groups are harmless in Vim and Neovim.
hi! link ColorLineNormal User1
hi! link ColorLineInsert User6
hi! link ColorLineVisual User7
hi! link ColorLineReplace User4
hi! link ColorLineCommand User1
hi! link ColorLineInactive User3
hi! link ColorLineGitAdd User6
hi! link ColorLineGitChange User7
hi! link ColorLineGitDelete User8
hi! link SkylineNormal User1
hi! link SkylineInsert User6
hi! link SkylineVisual User7
hi! link SkylineReplace User4
hi! link SkylineCommand User1
hi! link SkylineInactive User3
hi! link SkylineGitAdd User6
hi! link SkylineGitChange User7
hi! link SkylineGitDelete User8
hi! link MiniStatuslineModeNormal User1
hi! link MiniStatuslineModeInsert User6
hi! link MiniStatuslineModeVisual User7
hi! link MiniStatuslineModeReplace User4
hi! link MiniStatuslineModeCommand User1
hi! link MiniStatuslineModeOther User2
hi! link MiniStatuslineDevinfo User2
hi! link MiniStatuslineFileinfo User2
hi! link MiniStatuslineFilename User3
hi! link MiniStatuslineInactive User3
hi! link GitGutterAdd User6
hi! link GitGutterChange User7
hi! link GitGutterDelete User8
hi! link GitGutterChangeDelete User4
hi! link SignifySignAdd GitGutterAdd
hi! link SignifySignChange GitGutterChange
hi! link SignifySignDelete GitGutterDelete
hi! link GitSignsAdd GitGutterAdd
hi! link GitSignsChange GitGutterChange
hi! link GitSignsDelete GitGutterDelete

" =============================================================================
" Diagnostics & Diff
" =============================================================================
if has('nvim')
  execute 'hi DiagnosticUnderlineError gui=undercurl guisp=#e77e79'
  execute 'hi DiagnosticUnderlineWarn  gui=undercurl guisp=#f0d487'
  execute 'hi DiagnosticUnderlineInfo  gui=undercurl guisp=#6f8ee6'
  execute 'hi DiagnosticUnderlineHint  gui=undercurl guisp=#6fd4a8'
endif

call s:hi('DiffAdd', s:p.bg, s:p.emerald, '233', '71', 'NONE')
call s:hi('DiffChange', s:p.bg, s:p.sky, '233', '69', 'NONE')
call s:hi('DiffDelete', s:p.bg, s:p.vermilion, '233', '167', 'NONE')
call s:hi('DiffText', s:p.bg, s:p.ochre, '233', '221', 'bold')

" =============================================================================
" Rigorous Mode (Opt-in Habit Enforcement)
" =============================================================================
call s:hi('FuncKey', s:p.jade, 'NONE', '36', 'NONE', 'bold')

function! s:ForceSeoulismTypes() abort
  if !g:seoulism_rigorous | return | endif
  if exists('w:seoulism_type_matches')
    for l:match_id in w:seoulism_type_matches
      silent! call matchdelete(l:match_id)
    endfor
  endif
  let w:seoulism_type_matches = []
  let l:type_pattern = '\v<[A-Z][a-zA-Z0-9_]+>|<\w+_t>'
  let l:id = matchadd('Type', l:type_pattern, 15)
  call add(w:seoulism_type_matches, l:id)
endfunction

function! s:ForceSeoulismJade() abort
  if !g:seoulism_rigorous | return | endif
  if exists('w:seoulism_jade_match')
    silent! call matchdelete(w:seoulism_jade_match)
  endif
  let w:seoulism_jade_match = matchadd('FuncKey', '\<func\>\|\<\w\+\>\s\+\zs\w\+\ze\s*(')
endfunction

if g:seoulism_rigorous
  augroup SeoulismRigorous
    autocmd!
    autocmd FileType c,cpp,go,rust,java,python,typescript call s:ForceSeoulismTypes()
    autocmd BufEnter,WinEnter * if &filetype =~# 'c\|cpp\|go\|rust\|java\|python\|typescript' | call s:ForceSeoulismTypes() | endif
    autocmd BufEnter,WinEnter,Syntax go,c,cpp,rust,python call s:ForceSeoulismJade()
  augroup END
  call s:ForceSeoulismTypes()
endif

" =============================================================================
" Integrations
" =============================================================================
if has('nvim')
  hi! link @keyword Keyword
  hi! link @conditional Conditional
  hi! link @repeat Repeat
  hi! link @exception Exception
  hi! link @variable Identifier
  hi! link @function.builtin Function
  hi! link @keyword.function FuncKey
  hi! link @keyword.method FuncKey
  hi! link @function FuncKey
  hi! link @lsp.type.type Type
  hi! link @lsp.type.struct Type
  hi! link @lsp.type.enum Type
  hi! link @lsp.type.typedef Type
  hi! link @lsp.type.class Type

  let g:terminal_color_0 = s:p.bg
  let g:terminal_color_1 = s:p.vermilion
  let g:terminal_color_2 = s:p.emerald
  let g:terminal_color_3 = s:p.ochre
  let g:terminal_color_4 = s:p.royal_blue
  let g:terminal_color_5 = s:p.vermilion
  let g:terminal_color_6 = s:p.jade
  let g:terminal_color_7 = '#d4d3cf'
  let g:terminal_color_8 = s:p.charcoal
  let g:terminal_color_9 = '#e77e79'
endif

" LSP Semantic Token Groups
call s:hi('LspVariable', s:p.fg, 'NONE', '255', 'NONE', 'NONE')
call s:hi('LspParameter', '#6bc0b6', 'NONE', '73', 'NONE', s:italic)
call s:hi('LspKeyword', s:p.vermilion, 'NONE', '167', 'NONE', 'bold')
call s:hi('LspControlFlow', s:p.vermilion, 'NONE', '167', 'NONE', 'bold')
call s:hi('LspStaticVariable', s:p.ochre, 'NONE', '221', 'NONE', 'bold')
call s:hi('LspEnumMember', s:p.ochre, 'NONE', '221', 'NONE', 'NONE')
call s:hi('LspInterface', s:p.fg_bright, 'NONE', '231', 'NONE', 'bold')
call s:hi('LspStruct', s:p.fg_bright, 'NONE', '231', 'NONE', s:italic)
call s:hi('LspErrorText', '#e77e79', 'NONE', '203', 'NONE', 'underline')
call s:hi('LspWarningText', s:p.gold, 'NONE', '222', 'NONE', 'underline')
