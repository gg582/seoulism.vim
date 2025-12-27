" =============================================================================
" Seoulism Syntax Balance Checker
" Description: Structural analysis based on Five Elements syntax mapping.
" =============================================================================

if exists('g:loaded_seoulism_checker') | finish | endif
let g:loaded_seoulism_checker = 1

let g:seoulism_threshold = 15.0

highlight SeoulismWarn ctermfg=Yellow guifg=Yellow
sign define SeoulismSign text=☯ texthl=SeoulismWarn

" --- Syntax Mapping ---
let s:elements = {
    \ 'WOOD':  ['Function', 'Identifier'],
    \ 'FIRE':  ['Statement', 'Conditional', 'Repeat', 'Exception'],
    \ 'EARTH': ['Constant', 'String', 'Number', 'Boolean', 'Float'],
    \ 'METAL': ['Type', 'StorageClass', 'Structure', 'Typedef'],
    \ 'WATER': ['Comment', 'Special', 'Delimiter']
    \ }

let s:overcomes = {
    \ 'WOOD':  'EARTH',
    \ 'EARTH': 'WATER',
    \ 'WATER': 'FIRE',
    \ 'FIRE':  'METAL',
    \ 'METAL': 'WOOD'
    \ }

function! s:AnalyzeSyntax() abort
    let l:stats = {'WOOD': 0, 'FIRE': 0, 'EARTH': 0, 'METAL': 0, 'WATER': 0}
    let l:total = 0
    let l:lines = getline(1, '$')
    
    for l:lnum in range(1, len(l:lines))
        let l:line_text = l:lines[l:lnum - 1]
        let l:words = split(l:line_text, '\W\+')
        for l:word in l:words
            let l:cnum = stridx(l:line_text, l:word) + 1
            let l:hi_id = synID(l:lnum, l:cnum, 1)
            let l:hi_name = synIDattr(synIDtrans(l:hi_id), 'name')
            
            for [l:el, l:groups] in items(s:elements)
                if index(l:groups, l:hi_name) >= 0
                    let l:stats[l:el] += 1
                    let l:total += 1
                    break
                endif
            endfor
        endfor
    endfor
    return [l:stats, l:total]
endfunction

function! SeoulismCheck() abort
    let [l:stats, l:total] = s:AnalyzeSyntax()
    execute 'sign unplace 999 buffer=' . bufnr('%')
    if l:total == 0 | return | endif

    for [l:attacker, l:victim] in items(s:overcomes)
        let l:p_att = (l:stats[l:attacker] * 100.0) / l:total
        let l:p_vic = (l:stats[l:victim] * 100.0) / l:total
        if (l:p_att - l:p_vic) > g:seoulism_threshold
            execute 'sign place 999 line=1 name=SeoulismSign buffer=' . bufnr('%')
            echo "[Seoulism] Imbalance: " . l:attacker . " dominates " . l:victim
            return
        endif
    endfor
endfunction

function! SeoulismReport() abort
    let [l:stats, l:total] = s:AnalyzeSyntax()
    if l:total == 0 | echo "No syntax data found." | return | endif

    echo "--- Syntax Distribution Report ---"
    for l:el in ['WOOD', 'FIRE', 'EARTH', 'METAL', 'WATER']
        let l:p = (l:stats[l:el] * 100.0) / l:total
        echo printf("%-6s: [%-20s] %.1f%%", l:el, repeat('#', float2nr(l:p / 5)), l:p)
    endfor
    echo "----------------------------------"

    " --- Structural Characteristics Analysis ---
    if l:stats['WATER'] > (l:total * 0.4)
        echo "Analysis: Documentation-heavy structure (Header or Verbose Comments)."
    elseif l:stats['FIRE'] > (l:total * 0.3)
        echo "Analysis: Control-flow intensive (Logic or Algorithm implementation)."
    elseif l:stats['EARTH'] > (l:total * 0.4)
        echo "Analysis: Data-centric structure (Configuration or Constants file)."
    elseif l:stats['METAL'] > (l:total * 0.3)
        echo "Analysis: Definition-heavy structure (Header file or Type declarations)."
    elseif l:stats['WOOD'] > (l:total * 0.3)
        echo "Analysis: Identifier-rich structure (Reference-heavy or API-intensive)."
    else
        echo "Analysis: Balanced syntax distribution."
    endif
endfunction

command! SeoulismStatus call SeoulismReport()

augroup SeoulismChecker
    autocmd!
    autocmd BufWritePost * call SeoulismCheck()
augroup END
