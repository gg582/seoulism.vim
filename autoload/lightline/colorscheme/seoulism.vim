" autoload/lightline/colorscheme/seoulism.vim
scriptencoding utf-8

" Color palette definition: [gui, cterm]
let s:bg       = ['#181a1f', 233]
let s:bg_faint = ['#121318', 232]
let s:bg_int   = ['#2b2e36', 235]

let s:fg       = ['#eeeeee', 255]
let s:fg_faint = ['#d7d6d2', 250]
let s:fg_i     = ['#f9f9f9', 231]

let s:red      = ['#e05a55', 203]
let s:red_dim  = ['#b24a45', 131]

let s:blue     = ['#3f6bd9', 26]
let s:jade     = ['#359489', 36]
let s:green    = ['#35a06f', 35]
let s:yellow   = ['#e5c15a', 221]
let s:gray     = ['#5f6770', 239]

" Helper function to generate segment
function! s:seg(fg, bg, ...) abort
  let l:attr = a:0 ? a:1 : 'NONE'
  return [a:fg[0], a:bg[0], a:fg[1], a:bg[1], l:attr]
endfunction

let s:p = {}

" --- Normal Mode ---
let s:p.normal = {}
let s:p.normal.left = [
      \ s:seg(s:bg, s:red_dim, 'bold'),
      \ s:seg(s:fg, s:bg_int),
      \ ]
let s:p.normal.middle = [ s:seg(s:fg_faint, s:bg_faint) ]
let s:p.normal.right = [
      \ s:seg(s:bg, s:red, 'bold'),
      \ s:seg(s:fg, s:bg_int),
      \ s:seg(s:fg_faint, s:bg_faint),
      \ ]
let s:p.normal.error = [ s:seg(s:red, s:bg_int, 'bold') ]
let s:p.normal.warning = [ s:seg(s:red_dim, s:bg_int) ]
let s:p.normal.special = [ s:seg(s:fg_i, s:bg_int, 'bold') ]

" --- Insert Mode ---
let s:p.insert = {}
let s:p.insert.left = [
      \ s:seg(s:bg, s:green, 'bold'),
      \ s:seg(s:fg, s:bg_int),
      \ ]
let s:p.insert.middle = s:p.normal.middle
let s:p.insert.right = [
      \ s:seg(s:bg, s:green, 'bold'),
      \ s:seg(s:fg, s:bg_int),
      \ s:seg(s:fg_faint, s:bg_faint),
      \ ]

" --- Visual Mode ---
let s:p.visual = {}
let s:p.visual.left = [
      \ s:seg(s:bg, s:blue, 'bold'),
      \ s:seg(s:fg, s:bg_int),
      \ ]
let s:p.visual.middle = s:p.normal.middle
let s:p.visual.right = [
      \ s:seg(s:bg, s:blue, 'bold'),
      \ s:seg(s:fg, s:bg_int),
      \ s:seg(s:fg_faint, s:bg_faint),
      \ ]

" --- Replace Mode ---
let s:p.replace = {}
let s:p.replace.left = [
      \ s:seg(s:bg, s:yellow, 'bold'),
      \ s:seg(s:fg, s:bg_int),
      \ ]
let s:p.replace.middle = s:p.normal.middle
let s:p.replace.right = [
      \ s:seg(s:bg, s:yellow, 'bold'),
      \ s:seg(s:fg, s:bg_int),
      \ s:seg(s:fg_faint, s:bg_faint),
      \ ]

" --- Command Mode ---
let s:p.command = {}
let s:p.command.left = [
      \ s:seg(s:bg, s:red_dim, 'bold'),
      \ s:seg(s:fg, s:bg_int),
      \ ]
let s:p.command.middle = s:p.normal.middle
let s:p.command.right = [
      \ s:seg(s:bg, s:red_dim, 'bold'),
      \ s:seg(s:fg, s:bg_int),
      \ s:seg(s:fg_faint, s:bg_faint),
      \ ]

" --- Inactive ---
let s:p.inactive = {}
let s:p.inactive.left = [ s:seg(s:fg_faint, s:bg_faint), s:seg(s:fg_faint, s:bg_faint) ]
let s:p.inactive.middle = [ s:seg(s:fg_faint, s:bg_faint) ]
let s:p.inactive.right = [ s:seg(s:fg_faint, s:bg_faint), s:seg(s:fg_faint, s:bg_faint) ]

" --- Tabline ---
let s:p.tabline = {}
let s:p.tabline.left = [ s:seg(s:fg_faint, s:bg_int) ]
let s:p.tabline.middle = [ s:seg(s:fg_faint, s:bg_faint) ]
let s:p.tabline.right = [ s:seg(s:fg_faint, s:bg_int) ]
let s:p.tabline.tabsel = [ s:seg(s:bg, s:jade, 'bold') ]

" Logic: Ex mode (Command) represents the 'Order of Metal'
" 1. Command-line area (where you type :) colors
highlight CommandModeMsg guifg=#efeeea guibg=#111116 gui=bold
highlight ModeMsg guifg=#efeeea gui=bold

" 2. Force StatusLine to stay in Metal tone during Command mode
augroup SeoulismCommandLogic
  autocmd!
  autocmd CmdLineEnter * highlight StatusLine guifg=#111116 guibg=#efeeea gui=bold
  autocmd CmdLineLeave * highlight StatusLine guifg=#efeeea guibg=#2b2e36 gui=bold
augroup END

" 3. Control Characters (^[, ^@) - Shadow Logic
highlight SpecialKey guifg=#5f6770
highlight NonText guifg=#5f6770

" Register the palette
let g:lightline#colorscheme#seoulism#palette = lightline#colorscheme#fill(s:p)
