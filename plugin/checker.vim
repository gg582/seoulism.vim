" =============================================================================
" Seoulism Structural Balance Checker (Opt-in)
" =============================================================================
" This script analyzes code structure based on the Seoulism philosophy.
" Enable it with: let g:seoulism_enable_checker = 1

if exists('g:loaded_seoulism_checker') | finish | endif
let g:loaded_seoulism_checker = 1

" Master Switch: Default to OFF for 'Star-first' compatibility
if !get(g:, 'seoulism_enable_checker', 0)
    finish
endif

" --- Configuration ---
if !exists('g:seoulism_warn_opp') | let g:seoulism_warn_opp = 0 | endif
if !exists('g:seoulism_opp_threshold') | let g:seoulism_opp_threshold = 25.0 | endif
if !exists('g:seoulism_risk_gap') | let g:seoulism_risk_gap = 40.0 | endif
if !exists('g:seoulism_checkpoint_span') | let g:seoulism_checkpoint_span = 24 | endif
if !exists('g:seoulism_checkpoint_sign') | let g:seoulism_checkpoint_sign = 's' | endif
if !exists('g:seoulism_sample_step') | let g:seoulism_sample_step = 2 | endif
if !exists('g:seoulism_sign_text') | let g:seoulism_sign_text = '◆' | endif
if !exists('g:seoulism_scope') | let g:seoulism_scope = 'context' | endif
if !exists('g:seoulism_context_lines') | let g:seoulism_context_lines = 80 | endif

highlight SeoulismWarn ctermfg=180 guifg=#e5c15a
execute 'sign define SeoulismSign text=' . g:seoulism_sign_text . ' texthl=SeoulismWarn'
execute 'sign define SeoulismConflict text=' . g:seoulism_checkpoint_sign . ' texthl=SeoulismWarn'

let s:elements = {
    \ 'FUNCTION': ['Function', 'Identifier'],
    \ 'CONTROL':  ['Statement', 'Conditional', 'Repeat', 'Exception'],
    \ 'DATA':      ['Constant', 'String', 'Number', 'Boolean', 'Float'],
    \ 'TYPE':      ['Type', 'StorageClass', 'Structure', 'Typedef'],
    \ 'META':      ['Comment', 'Special']
    \ }

let s:dominance = {
    \ 'FUNCTION': 'DATA',
    \ 'DATA':     'META',
    \ 'META':     'CONTROL',
    \ 'CONTROL':  'TYPE',
    \ 'TYPE':     'FUNCTION'
    \ }

let s:trend_labels = {
    \ 'FUNCTION': 'Function-driven',
    \ 'CONTROL':  'Flow-heavy',
    \ 'DATA':     'Data-centric',
    \ 'TYPE':     'Definition-heavy',
    \ 'META':     'Annotation-heavy'
    \ }

let s:sign_id = 500

function! s:NextSignId() abort
    let s:sign_id += 1
    return s:sign_id
endfunction

function! s:BlankStats() abort
    return {'FUNCTION': 0, 'CONTROL': 0, 'DATA': 0, 'TYPE': 0, 'META': 0}
endfunction

function! s:TrendLabel(element) abort
    return get(s:trend_labels, a:element, a:element)
endfunction

function! s:BuildRiskNotice(leader, follower, diff) abort
    return printf('%s trend is overwhelming %s by %.1f%%; rebalance this window.',
        \ s:TrendLabel(a:leader), s:TrendLabel(a:follower), a:diff)
endfunction

function! s:FindConflictRange(samples, leader, follower) abort
    if empty(a:samples)
        return {}
    endif

    let l:span = max([4, get(g:, 'seoulism_checkpoint_span', 24)])
    let l:last_line = a:samples[len(a:samples) - 1].lnum
    let l:best = {}
    let l:max_gap = -1.0

    for l:i in range(0, len(a:samples) - 1)
        let l:start_line = a:samples[l:i].lnum
        let l:end_line = l:start_line + l:span - 1
        let l:leader_total = 0
        let l:follower_total = 0
        let l:window_total = 0

        for l:j in range(l:i, len(a:samples) - 1)
            let l:item = a:samples[l:j]
            if l:item.lnum > l:end_line
                break
            endif
            let l:leader_total += get(l:item.stats, a:leader, 0)
            let l:follower_total += get(l:item.stats, a:follower, 0)
            let l:window_total += l:item.total
        endfor

        if l:window_total == 0
            continue
        endif

        let l:diff = ((l:leader_total - l:follower_total) * 100.0) / l:window_total
        if l:diff > l:max_gap
            let l:max_gap = l:diff
            let l:best = {'start': l:start_line, 'end': min([l:end_line, l:last_line])}
        endif
    endfor

    return l:best
endfunction

function! s:PlaceConflictSigns(range, buf) abort
    if empty(a:range)
        return ''
    endif

    for l:lnum in range(a:range.start, a:range.end)
        execute 'sign place ' . s:NextSignId()
            \ . ' group=SeoulismOpp line=' . l:lnum
            \ . ' name=SeoulismConflict buffer=' . a:buf
    endfor

    return printf('%d-%d', a:range.start, a:range.end)
endfunction

function! s:ScanRange(first, last) abort
    let l:stats = s:BlankStats()
    let l:total = 0
    let l:samples = []

    for l:lnum in range(a:first, a:last)
        let l:line_str = getline(l:lnum)
        if empty(trim(l:line_str)) | continue | endif

        let l:width = col([l:lnum, '$'])
        let l:line_stats = s:BlankStats()
        let l:line_total = 0
        for l:cnum in range(1, l:width, g:seoulism_sample_step)
            let l:hi_id = synID(l:lnum, l:cnum, 1)
            let l:hi_name = synIDattr(synIDtrans(l:hi_id), 'name')

            if l:hi_name ==# '' || l:hi_name ==# 'Delimiter' | continue | endif

            for [l:el, l:groups] in items(s:elements)
                let l:matched = 0
                for l:group in l:groups
                    if l:hi_name =~# l:group
                        let l:stats[l:el] += 1
                        let l:line_stats[l:el] += 1
                        let l:total += 1
                        let l:line_total += 1
                        let l:matched = 1
                        break
                    endif
                endfor
                if l:matched | break | endif
            endfor
        endfor

        if l:line_total > 0
            call add(l:samples, {'lnum': l:lnum, 'stats': l:line_stats, 'total': l:line_total})
        endif
    endfor
    return [l:stats, l:total, l:samples]
endfunction

function! s:RealTimeCheck() abort
    if !g:seoulism_warn_opp | return | endif

    let l:cur = line('.')
    let l:first = max([1, l:cur - g:seoulism_context_lines])
    let l:last  = min([line('$'), l:cur + g:seoulism_context_lines])

    let [l:stats, l:total, l:samples] = s:ScanRange(l:first, l:last)
    if l:total == 0 | return | endif

    let l:p = {}
    for l:k in keys(l:stats)
        let l:p[l:k] = (l:stats[l:k] * 100.0) / l:total
    endfor

    let l:profile = 'Balanced'
    if l:p['META'] > 60.0    | let l:profile = 'Annotation-heavy'
    elseif l:p['CONTROL'] > 35.0 | let l:profile = 'Flow-heavy'
    elseif l:p['DATA'] > 50.0    | let l:profile = 'Data-centric'
    elseif l:p['TYPE'] > 40.0    | let l:profile = 'Definition-heavy'
    endif

    let l:dom_msg = ''
    let l:notice_msg = ''
    let l:checkpoint_msg = ''
    silent! execute 'sign unplace * group=SeoulismOpp buffer=' . bufnr('%')

    for [l:leader, l:follower] in items(s:dominance)
        let l:gap = l:p[l:leader] - l:p[l:follower]
        if l:gap > g:seoulism_opp_threshold
            if l:gap >= g:seoulism_risk_gap
                let l:range = s:FindConflictRange(l:samples, l:leader, l:follower)
                if !empty(l:range)
                    let l:checkpoint = s:PlaceConflictSigns(l:range, bufnr('%'))
                    if !empty(l:checkpoint)
                        let l:checkpoint_msg = printf(' | Checkpoint %s marked (s)', l:checkpoint)
                    endif
                else
                    execute 'sign place ' . s:NextSignId() . ' group=SeoulismOpp line=' . line('.') . ' name=SeoulismSign buffer=' . bufnr('%')
                endif
                let l:notice_msg = ' | Notice: ' . s:BuildRiskNotice(l:leader, l:follower, l:gap)
            else
                execute 'sign place ' . s:NextSignId() . ' group=SeoulismOpp line=' . line('.') . ' name=SeoulismSign buffer=' . bufnr('%')
            endif
            let l:dom_msg = printf(' | Dominance: %s > %s (Δ%.1f%%)', l:leader, l:follower, l:gap)
            break
        endif
    endfor

    let l:msg = printf('[Seoulism] %s | Profile: %s | FUNC %.1f%% CTRL %.1f%% DATA %.1f%% TYPE %.1f%% META %.1f%%%s%s%s',
        \ g:seoulism_scope, l:profile, l:p['FUNCTION'], l:p['CONTROL'], l:p['DATA'], l:p['TYPE'], l:p['META'],
        \ l:dom_msg, l:checkpoint_msg, l:notice_msg)

    if !exists('b:seoulism_last_msg') || l:msg !=# b:seoulism_last_msg
        let b:seoulism_last_msg = l:msg
        echo l:msg
    endif
endfunction

" Commands & Autocmds
command! Opp let g:seoulism_warn_opp = 1 | call s:RealTimeCheck()
command! NoOpp let g:seoulism_warn_opp = 0 | silent! execute 'sign unplace * group=SeoulismOpp buffer=' . bufnr('%')
cnoreabbrev wopp Opp
cnoreabbrev noopp NoOpp

augroup SeoulismRealTime
    autocmd!
    autocmd CursorHold,CursorHoldI,BufWritePost * call s:RealTimeCheck()
augroup END