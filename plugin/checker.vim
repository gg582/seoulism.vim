" =============================================================================
" Seoulism Elemental Overcoming Checker (Real-time Analysis)
" =============================================================================

if exists('g:loaded_seoulism_checker') | finish | endif
let g:loaded_seoulism_checker = 1

if !exists('g:seoulism_warn_opp') | let g:seoulism_warn_opp = 1 | endif
if !exists('g:seoulism_opp_threshold') | let g:seoulism_opp_threshold = 10.0 | endif

" Optional knobs (do not change user's global options unless asked)
if !exists('g:seoulism_sample_step') | let g:seoulism_sample_step = 10 | endif
if !exists('g:seoulism_sign_text') | let g:seoulism_sign_text = '☯' | endif
if !exists('g:seoulism_force_updatetime') | let g:seoulism_force_updatetime = 0 | endif
if g:seoulism_force_updatetime
    " Setting global options in a plugin can be intrusive; keep it opt-in.
    set updatetime=500
endif

highlight SeoulismWarn ctermfg=Yellow guifg=Yellow
execute 'sign define SeoulismSign text=' . g:seoulism_sign_text . ' texthl=SeoulismWarn'

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

function! s:Clamp01to100Float(x) abort
    let l:v = a:x
    if l:v < 0.0 | let l:v = 0.0 | endif
    if l:v > 100.0 | let l:v = 100.0 | endif
    return l:v
endfunction

function! s:SetWarnCfg(arg) abort
    let l:v = str2float(a:arg)
    let g:seoulism_opp_threshold = s:Clamp01to100Float(l:v)
    echo printf('[Seoulism] warncfg=%.1f (higher = stricter, less output)', g:seoulism_opp_threshold)
endfunction

function! s:RealTimeCheck() abort
    if !g:seoulism_warn_opp | return | endif
    if !exists('g:syntax_on') && &syntax ==# '' | return | endif

    " Clear previous sign (grouped to avoid collisions)
    silent! execute 'sign unplace * group=SeoulismOpp buffer=' . bufnr('%')

    let l:stats = {'WOOD': 0, 'FIRE': 0, 'EARTH': 0, 'METAL': 0, 'WATER': 0}
    let l:total = 0
    let l:first = line('w0')
    let l:last = line('w$')

    " Scan visible area for real-time feedback
    for l:lnum in range(l:first, l:last)
        let l:width = col([l:lnum, '$'])
        for l:cnum in range(1, l:width, g:seoulism_sample_step)
            let l:hi_id = synID(l:lnum, l:cnum, 1)
            let l:hi_name = synIDattr(synIDtrans(l:hi_id), 'name')

            let l:matched = 0
            for [l:el, l:groups] in items(s:elements)
                for l:group in l:groups
                    if l:hi_name =~# l:group
                        let l:stats[l:el] += 1
                        let l:total += 1
                        let l:matched = 1
                        break
                    endif
                endfor
                if l:matched | break | endif
            endfor
        endfor
    endfor

    if l:total == 0 | return | endif

    " 1. Analyze Structural Profile (Real-time info)
    let l:profile = 'Balanced'
    if l:stats['WATER'] > (l:total * 0.4)
        let l:profile = 'Documentation-heavy (Header-like)'
    elseif l:stats['FIRE'] > (l:total * 0.3)
        let l:profile = 'Logic-intensive (Control-flow)'
    elseif l:stats['EARTH'] > (l:total * 0.4)
        let l:profile = 'Data-centric (Values/Constants)'
    elseif l:stats['METAL'] > (l:total * 0.3)
        let l:profile = 'Definition-heavy (Typedef/Struct)'
    elseif l:stats['WOOD'] > (l:total * 0.3)
        let l:profile = 'Reference-rich (API/Functions)'
    endif

    " 2. Detect Overcoming
    let l:conflict_msg = ''
    for [l:attacker, l:victim] in items(s:overcomes)
        let l:p_att = (l:stats[l:attacker] * 100.0) / l:total
        let l:p_vic = (l:stats[l:victim] * 100.0) / l:total
        if (l:p_att - l:p_vic) > g:seoulism_opp_threshold
            execute 'sign place 999 group=SeoulismOpp line=' . l:first . ' name=SeoulismSign buffer=' . bufnr('%')
            let l:conflict_msg = printf(' | Overcome: %s > %s', l:attacker, l:victim)
            break
        endif
    endfor

    " 3. Output (avoid spamming the command line)
    let l:msg = '[Seoulism] Profile: ' . l:profile . l:conflict_msg
    if !exists('b:seoulism_last_msg') | let b:seoulism_last_msg = '' | endif
    if l:msg !=# b:seoulism_last_msg
        let b:seoulism_last_msg = l:msg
        echo l:msg
    endif
endfunction

command! Opp let g:seoulism_warn_opp = 1 | call s:RealTimeCheck()
command! NoOpp let g:seoulism_warn_opp = 0 | silent! execute 'sign unplace * group=SeoulismOpp buffer=' . bufnr('%') | echo '[Seoulism] Disabled.'
command! -nargs=1 WarnCfg call s:SetWarnCfg(<q-args>)

cnoreabbrev wopp Opp
cnoreabbrev noopp NoOpp
cnoreabbrev warncfg WarnCfg

augroup SeoulismRealTime
    autocmd!
    autocmd CursorHold,CursorHoldI,BufWritePost * call s:RealTimeCheck()
augroup END
