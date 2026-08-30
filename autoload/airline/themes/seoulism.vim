let g:airline#themes#seoulism#palette = {}

let s:bg       = '#111116'
let s:bg_faint = '#121318'
let s:bg_int   = '#2b2e36'
let s:fg       = '#efeeea'
let s:fg_faint = '#d7d6d2'
let s:red      = '#e05a55'
let s:green    = '#35a06f'
let s:yellow   = '#e5c15a'
let s:blue     = '#3f6bd9'
let s:jade     = '#359489'
let s:gray     = '#5f6770'

let s:N1 = [s:bg, s:red, 233, 167, 'bold']
let s:N2 = [s:fg, s:bg_int, 255, 235, '']
let s:N3 = [s:fg_faint, s:bg_faint, 250, 232, '']
let g:airline#themes#seoulism#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)
let g:airline#themes#seoulism#palette.normal_modified = {
      \ 'airline_c': [s:bg, s:yellow, 233, 221, 'bold'],
      \ }

let s:I1 = [s:bg, s:green, 233, 35, 'bold']
let s:I2 = [s:fg, s:bg_int, 255, 235, '']
let s:I3 = [s:fg_faint, s:bg_faint, 250, 232, '']
let g:airline#themes#seoulism#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)
let g:airline#themes#seoulism#palette.insert_modified = copy(g:airline#themes#seoulism#palette.normal_modified)
let g:airline#themes#seoulism#palette.insert_paste = {
      \ 'airline_a': [s:bg, s:yellow, 233, 221, 'bold'],
      \ }

let s:R1 = [s:bg, s:yellow, 233, 221, 'bold']
let s:R2 = [s:fg, s:bg_int, 255, 235, '']
let s:R3 = [s:fg_faint, s:bg_faint, 250, 232, '']
let g:airline#themes#seoulism#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
let g:airline#themes#seoulism#palette.replace_modified = copy(g:airline#themes#seoulism#palette.normal_modified)

let s:V1 = [s:bg, s:blue, 233, 26, 'bold']
let s:V2 = [s:fg, s:bg_int, 255, 235, '']
let s:V3 = [s:fg_faint, s:bg_faint, 250, 232, '']
let g:airline#themes#seoulism#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#seoulism#palette.visual_modified = copy(g:airline#themes#seoulism#palette.normal_modified)

let s:C1 = [s:bg, s:fg, 233, 255, 'bold']
let s:C2 = [s:fg, s:bg_int, 255, 235, '']
let s:C3 = [s:fg_faint, s:bg_faint, 250, 232, '']
let g:airline#themes#seoulism#palette.commandline = airline#themes#generate_color_map(s:C1, s:C2, s:C3)

let s:IA = [s:fg_faint, s:bg_faint, 250, 232, '']
let g:airline#themes#seoulism#palette.inactive = airline#themes#generate_color_map(s:IA, s:IA, s:IA)
let g:airline#themes#seoulism#palette.inactive_modified = {
      \ 'airline_c': [s:yellow, '', 221, '', ''],
      \ }

let g:airline#themes#seoulism#palette.accents = {
      \ 'red': [s:red, '', 167, '', ''],
      \ 'green': [s:green, '', 35, '', ''],
      \ 'yellow': [s:yellow, '', 221, '', ''],
      \ 'blue': [s:blue, '', 26, '', ''],
      \ }

if get(g:, 'loaded_ctrlp', 0)
  let g:airline#themes#seoulism#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
        \ [s:fg_faint, s:bg_int, 250, 235, ''],
        \ [s:fg, s:bg_faint, 255, 232, ''],
        \ [s:bg, s:jade, 233, 36, 'bold'])
endif
