" =============================================================================
" Seoulism Elemental Overcoming Checker
" Author: Seoulism Project
" Compatibility: Vim, Neovim
" Description: Monitors Five Elements balance and marks conflicts with ☯ sign.
" =============================================================================

if exists('g:loaded_seoulism_checker') | finish | endif
let g:loaded_seoulism_checker = 1

" --- Configuration ---
let g:seoulism_warn_opp = 1
let g:seoulism_opp_threshold = 10.0

" --- Visual Setup ---
highlight SeoulismWarn ctermfg=Yellow guifg=Yellow
" Define the Yin-Yang sign for the gutter
sign define SeoulismSign text=☯ texthl=SeoulismWarn

" --- Element Group Mapping ---
let s:elements = {
    \ 'WOOD':  ['Function', 'Identifier'],
    \ 'FIRE':  ['Statement', 'Conditional', 'Repeat', 'Exception'],
    \ 'EARTH': ['Constant', 'String', 'Number', 'Boolean', 'Float'],
    \ 'METAL': ['Type', 'StorageClass', 'Structure', 'Typedef'],
    \ 'WATER': ['Comment', 'Special', 'Delimiter']
    \ }

" --- Overcoming Logic ---
let s:conflicts = {
    \ 'WOOD':  'EARTH',
    \ 'EARTH': 'WATER',
    \ 'WATER': 'FIRE',
    \ 'FIRE':  'METAL',
    \ 'METAL': 'WOOD'
    \ }

function! s:CheckBalance() abort
    " Clear existing sign (ID 999) before re-checking
    execute 'sign unplace 999 buffer=' . bufnr('%')
    
    if !g:seoulism_warn_opp | return | endif

    let l:stats = {'WOOD': 0, 'FIRE': 0, 'EARTH': 0, 'METAL': 0, 'WATER': 0}
    let l:total = 0

    " Scan visible lines for performance
    let l:first = line('w0')
    let l:last = line('w$')

    for l:lnum in range(l:first, l:last)
        let l:width = col([l:lnum, '$'])
        " Sample every 10th character to prevent lag
        for l:cnum in range(1, l:width, 10)
            let l:hi_id = synID(l:lnum, l:cnum, 1)
            let l:hi_name = synIDattr(synIDtrans(l:hi_id), 'name')
            
            for [l:el, l:groups] in items(s:elements)
                for l:group in l:groups
                    if l:hi_name =~# l:group
                        let l:stats[l:el] += 1
                        let l:total += 1
                        break
                    endif
                endfor
            endfor
        endfor
    endfor

    if l:total == 0 | return | endif

    " Calculate and detect overwhelming energy
    for [l:attacker, l:victim] in items(s:conflicts)
        let l:p_attacker = (l:stats[l:attacker] * 100.0) / l:total
        let l:p_victim   = (l:stats[l:victim] * 100.0) / l:total
        let l:diff = l:p_attacker - l:p_victim

        if l:diff > g:seoulism_opp_threshold
            execute 'sign place 999 line=1 name=SeoulismSign buffer=' . bufnr('%')
            echohl WarningMsg
            echo printf("[Seoulism] Tendency: %s overwhelms %s (%.1f%% diff)", l:attacker, l:victim, l:diff)
            echohl None
            return
        endif
    endfor
endfunction

" --- User Commands ---
" :Opp (wopp) - Turn on checker
command! Opp let g:seoulism_warn_opp = 1 | call s:CheckBalance()
" :NoOpp (noopp) - Turn off checker
command! NoOpp let g:seoulism_warn_opp = 0 | execute 'sign unplace 999 buffer=' . bufnr('%') | echo "[Seoulism] Disabled."
" :WarnCfgOpp (warncfg) - Set threshold (%)
command! -nargs=1 WarnCfgOpp let g:seoulism_opp_threshold = str2float(<q-args>) | call s:CheckBalance()

" Command abbreviations for convenience
cnoreabbrev wopp Opp
cnoreabbrev noopp NoOpp
cnoreabbrev warncfg WarnCfgOpp

" --- Autocommands ---
augroup SeoulismChecker
    autocmd!
    " Trigger check when saving or when cursor stops moving
    autocmd BufWritePost,CursorHold * call s:CheckBalance()
augroup END
