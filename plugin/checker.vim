" =============================================================================
" Seoulism Elemental Overcoming Checker (Real-time Analysis)
" =============================================================================

if exists('g:loaded_seoulism_checker') | finish | endif
let g:loaded_seoulism_checker = 1

let g:seoulism_warn_opp = 1
let g:seoulism_opp_threshold = 10.0

highlight SeoulismWarn ctermfg=Yellow guifg=Yellow
sign define SeoulismSign text=☯ texthl=SeoulismWarn

let s:elements = {
    \ 'WOOD':  ['Function', 'Identifier'],
    \ 'FIRE':  ['Statement', 'Conditional', 'Repeat', 'Exception'],
    \ 'EARTH': ['Constant', 'String', 'Number', 'Boolean', 'Float'],
    \ 'METAL': ['Type', 'StorageClass', 'Structure', 'Typedef'],
    \ 'WATER': ['Comment', 'Special', 'Delimiter']
    \ }

let s:overcomes = {
    \ 'WOOD':  'EARTH', 'EARTH': 'WATER', 'WATER': 'FIRE', 'FIRE':  'METAL', 'METAL': 'WOOD'
    \ }

function! s:RealTimeCheck() abort
    if !g:seoulism_warn_opp | return | endif
    
    execute 'sign unplace 999 buffer=' . bufnr('%')
    
    let l:stats = {'WOOD': 0, 'FIRE': 0, 'EARTH': 0, 'METAL': 0, 'WATER': 0}
    let l:total = 0
    let l:first = line('w0')
    let l:last = line('w$')

    " Scan visible area for real-time feedback
    for l:lnum in range(l:first, l:last)
        let l:width = col([l:lnum, '$'])
        for l:cnum in range(1, l:width, 10)
            let l:hi_id = synID(l:lnum, l:cnum, 1)
            let l:hi_name = synIDattr(synIDtrans(l:hi_id), 'name')
            for [l:el, l:groups] in items(s:elements)
                for l:group in l:groups
                    if l:hi_name =~# l:group | let l:stats[l:el] += 1 | let l:total += 1 | break | endif
                endfor
            endfor
        endfor
    endfor

    if l:total == 0 | return | endif

    " 1. Analyze Structural Profile (Real-time info)
    let l:profile = "Balanced"
    if l:stats['WATER'] > (l:total * 0.4) | let l:profile = "Documentation-heavy (Header-like)"
    elseif l:stats['FIRE'] > (l:total * 0.3) | let l:profile = "Logic-intensive (Control-flow)"
    elseif l:stats['EARTH'] > (l:total * 0.4) | let l:profile = "Data-centric (Values/Constants)"
    elseif l:stats['METAL'] > (l:total * 0.3) | let l:profile = "Definition-heavy (Typedef/Struct)"
    elseif l:stats['WOOD'] > (l:total * 0.3) | let l:profile = "Reference-rich (API/Functions)"
    endif

    " 2. Detect Overcoming 
    let l:conflict_msg = ""
    for [l:attacker, l:victim] in items(s:overcomes)
        let l:p_att = (l:stats[l:attacker] * 100.0) / l:total
        let l:p_vic = (l:stats[l:victim] * 100.0) / l:total
        if (l:p_att - l:p_vic) > g:seoulism_opp_threshold
            execute 'sign place 999 line=1 name=SeoulismSign buffer=' . bufnr('%')
            let l:conflict_msg = printf(" | Overcome: %s > %s", l:attacker, l:victim)
            break
        endif
    endfor

    " 3. Output to command line (No command needed)
    echo "[Seoulism] Profile: " . l:profile . l:conflict_msg
endfunction

command! Opp let g:seoulism_warn_opp = 1 | call s:RealTimeCheck()
command! NoOpp let g:seoulism_warn_opp = 0 | execute 'sign unplace 999 buffer=' . bufnr('%') | echo "[Seoulism] Disabled."
cnoreabbrev wopp Opp
cnoreabbrev noopp NoOpp

augroup SeoulismRealTime
    autocmd!
    autocmd CursorHold,CursorHoldI,BufWritePost * call s:RealTimeCheck()
augroup END

" Set update time faster for snappier real-time feel (default is 4000ms)
set updatetime=500
