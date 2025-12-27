" =============================================================================
" Seoulism Elemental Overcoming Checker (Real-time Analysis)
" =============================================================================

if exists('g:loaded_seoulism_checker') | finish | endif
let g:loaded_seoulism_checker = 1

" Core switches
if !exists('g:seoulism_warn_opp') | let g:seoulism_warn_opp = 1 | endif
if !exists('g:seoulism_opp_threshold') | let g:seoulism_opp_threshold = 10.0 | endif

" Sampling / UI knobs
if !exists('g:seoulism_sample_step') | let g:seoulism_sample_step = 10 | endif
if !exists('g:seoulism_sign_text') | let g:seoulism_sign_text = '☯' | endif
if !exists('g:seoulism_force_updatetime') | let g:seoulism_force_updatetime = 0 | endif

" Scope:
"   'context' : cursor-centered ±g:seoulism_context_lines (default, human-friendly)
"   'window'  : visible window (w0..w$)
"   'buffer'  : whole buffer (incremental scan per tick to stay real-time)
if !exists('g:seoulism_scope') | let g:seoulism_scope = 'context' | endif
if !exists('g:seoulism_context_lines') | let g:seoulism_context_lines = 80 | endif
if !exists('g:seoulism_chunk_lines') | let g:seoulism_chunk_lines = 200 | endif

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

function! s:ScanRange(first, last) abort
    let l:stats = {'WOOD': 0, 'FIRE': 0, 'EARTH': 0, 'METAL': 0, 'WATER': 0}
    let l:total = 0

    for l:lnum in range(a:first, a:last)
        let l:width = col([l:lnum, '$'])

        " If the line is too short, still try once at column 1
        if l:width <= 1
            let l:width = 1
        endif

        for l:cnum in range(1, l:width, g:seoulism_sample_step)
            let l:hi_id = synID(l:lnum, l:cnum, 1)
            let l:hi_name = synIDattr(synIDtrans(l:hi_id), 'name')

            " Some buffers return empty names for plain whitespace; skip those.
            if l:hi_name ==# '' | continue | endif

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

    return [l:stats, l:total]
endfunction

function! s:GetScopeRange() abort
    if g:seoulism_scope ==# 'buffer'
        return [1, line('$'), 'buffer']
    elseif g:seoulism_scope ==# 'window'
        return [line('w0'), line('w$'), 'window']
    else
        " default: context around cursor
        let l:cur = line('.')
        let l:first = l:cur - g:seoulism_context_lines
        let l:last  = l:cur + g:seoulism_context_lines
        if l:first < 1 | let l:first = 1 | endif
        if l:last > line('$') | let l:last = line('$') | endif
        return [l:first, l:last, 'context']
    endif
endfunction

function! s:RealTimeCheck() abort
    if !g:seoulism_warn_opp | return | endif
    if !exists('g:syntax_on') && &syntax ==# '' | return | endif

    " Clear previous sign (grouped to avoid collisions)
    silent! execute 'sign unplace * group=SeoulismOpp buffer=' . bufnr('%')

    " Buffer-scope incremental scan state (keeps real-time feel)
    if g:seoulism_scope ==# 'buffer'
        if !exists('b:seoulism_tick')
            let b:seoulism_tick = -1
            let b:seoulism_scan_pos = 1
            let b:seoulism_buf_stats = {'WOOD': 0, 'FIRE': 0, 'EARTH': 0, 'METAL': 0, 'WATER': 0}
            let b:seoulism_buf_total = 0
            let b:seoulism_scan_done = 0
        endif

        " Reset when buffer changed
        if b:seoulism_tick !=# b:changedtick
            let b:seoulism_tick = b:changedtick
            let b:seoulism_scan_pos = 1
            let b:seoulism_buf_stats = {'WOOD': 0, 'FIRE': 0, 'EARTH': 0, 'METAL': 0, 'WATER': 0}
            let b:seoulism_buf_total = 0
            let b:seoulism_scan_done = 0
        endif

        let l:first = b:seoulism_scan_pos
        let l:last  = min([line('$'), b:seoulism_scan_pos + g:seoulism_chunk_lines - 1])

        let [l:chunk_stats, l:chunk_total] = s:ScanRange(l:first, l:last)

        if l:chunk_total > 0
            for l:k in keys(l:chunk_stats)
                let b:seoulism_buf_stats[l:k] += l:chunk_stats[l:k]
            endfor
            let b:seoulism_buf_total += l:chunk_total
        endif

        " Advance scan
        if l:last >= line('$')
            let b:seoulism_scan_pos = 1
            let b:seoulism_scan_done = 1
        else
            let b:seoulism_scan_pos = l:last + 1
        endif

        let l:stats = b:seoulism_buf_stats
        let l:total = b:seoulism_buf_total
        let l:scope_label = 'buffer'
    else
        let [l:first, l:last, l:scope_label] = s:GetScopeRange()
        let [l:stats, l:total] = s:ScanRange(l:first, l:last)

        " If you were on a blank area and got no samples, fall back to window scan once.
        if l:total == 0 && l:scope_label !=# 'window'
            let [l:stats, l:total] = s:ScanRange(line('w0'), line('w$'))
            let l:scope_label = 'window'
        endif
    endif

    if l:total == 0
        " Nothing to sample (e.g., very short buffer or no syntax groups)
        " Avoid spamming; only echo if it changes.
        let l:msg = '[Seoulism] No samples (scope=' . l:scope_label . ').'
        if !exists('b:seoulism_last_msg') | let b:seoulism_last_msg = '' | endif
        if l:msg !=# b:seoulism_last_msg
            let b:seoulism_last_msg = l:msg
            echo l:msg
        endif
        return
    endif

    " Compute percentages
    let l:p_wood  = (l:stats['WOOD']  * 100.0) / l:total
    let l:p_fire  = (l:stats['FIRE']  * 100.0) / l:total
    let l:p_earth = (l:stats['EARTH'] * 100.0) / l:total
    let l:p_metal = (l:stats['METAL'] * 100.0) / l:total
    let l:p_water = (l:stats['WATER'] * 100.0) / l:total

    let l:mix_msg = printf(
        \ ' | Mix: WOOD %.1f%% FIRE %.1f%% EARTH %.1f%% METAL %.1f%% WATER %.1f%%',
        \ l:p_wood, l:p_fire, l:p_earth, l:p_metal, l:p_water
        \ )

    if g:seoulism_scope ==# 'buffer' && exists('b:seoulism_scan_done') && !b:seoulism_scan_done
        let l:scan_pct = float2nr((b:seoulism_scan_pos * 100.0) / max([1, line('$')]))
        let l:mix_msg .= printf(' | Scan %d%%', l:scan_pct)
    endif

    " 1) Structural profile
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

    " 2) Overcoming detection
    let l:conflict_msg = ''
    for [l:attacker, l:victim] in items(s:overcomes)
        let l:p_att = (l:stats[l:attacker] * 100.0) / l:total
        let l:p_vic = (l:stats[l:victim] * 100.0) / l:total
        if (l:p_att - l:p_vic) > g:seoulism_opp_threshold
            " Place sign on current cursor line (not window first line)
            execute 'sign place 999 group=SeoulismOpp line=' . line('.') . ' name=SeoulismSign buffer=' . bufnr('%')
            let l:conflict_msg = printf(' | Overcome: %s > %s', l:attacker, l:victim)
            break
        endif
    endfor

    " 3) Output (avoid spamming command line)
    let l:msg = '[Seoulism] Scope: ' . l:scope_label . ' | Profile: ' . l:profile . l:mix_msg . l:conflict_msg
    if !exists('b:seoulism_last_msg') | let b:seoulism_last_msg = '' | endif
    if l:msg !=# b:seoulism_last_msg
        let b:seoulism_last_msg = l:msg
        echo l:msg
    endif
endfunction

" Commands
command! Opp      let g:seoulism_warn_opp = 1 | call s:RealTimeCheck()
command! NoOpp    let g:seoulism_warn_opp = 0 | silent! execute 'sign unplace * group=SeoulismOpp buffer=' . bufnr('%') | echo '[Seoulism] Disabled.'
command! -nargs=1 WarnCfg call s:SetWarnCfg(<q-args>)

command! OppCtx   let g:seoulism_scope = 'context' | let g:seoulism_warn_opp = 1 | call s:RealTimeCheck()
command! OppWin   let g:seoulism_scope = 'window'  | let g:seoulism_warn_opp = 1 | call s:RealTimeCheck()
command! OppBuf   let g:seoulism_scope = 'buffer'  | let g:seoulism_warn_opp = 1 | call s:RealTimeCheck()

" Convenience abbreviations
cnoreabbrev wopp Opp
cnoreabbrev noopp NoOpp
cnoreabbrev warncfg WarnCfg

augroup SeoulismRealTime
    autocmd!
    autocmd CursorHold,CursorHoldI,BufWritePost * call s:RealTimeCheck()
augroup END
