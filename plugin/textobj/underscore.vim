if exists('g:loaded_textobj_underscore')
  finish
endif


call textobj#user#plugin('underscore', {
\   'code': {
\     'select-a-function': 'FindUnderscoreA',
\     'select-a': 'a_',
\     'select-i-function': 'FindUnderscoreI',
\     'select-i': 'i_',
\   },
\ })


function! FindUnderscoreA()
    call search('\v(_|\s|^)', 'eb', line('.'))
    let head_pos = getpos('.')
    call search('\v(_|\s|$)', 'e', line('.'))
    let tail_pos = getpos('.')
    return ['v', head_pos, tail_pos]
endfunction


function! FindUnderscoreI()
    call search('\v(_|\s|^)', 'eb', line('.'))
    " If not at the beginning of a line, move right.
    let char_under_cursor = getline('.')[col('.')-1]
    let in_first_col = col('.') == 1
    if !in_first_col || char_under_cursor =~ '\v(_|\s)'
        normal! l
    endif
    let head_pos = getpos('.')
    call search('\v(_|\s|$)', 'e', line('.'))
    " If not at the end of a line, move left.
    let char_under_cursor = getline('.')[col('.')-1]
    let in_last_col = col('.') == col('$') - 1
    if !in_last_col || char_under_cursor =~ '\v(_|\s)'
        normal! h
    endif
    let tail_pos = getpos('.')
    return ['v', head_pos, tail_pos]
endfunction


let g:loaded_textobj_underscore = 1
