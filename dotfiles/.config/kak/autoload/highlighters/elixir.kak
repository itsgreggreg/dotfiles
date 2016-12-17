# http://elixir-lang.org
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

# Detection
# ‾‾‾‾‾‾‾‾‾
hook global BufCreate .*(([.](ex|exs))) %{
    set buffer filetype elixir
}

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

addhl -group / regions -default code elixir       \
    double_string '"' (?<!\\)(\\\\)*"        '' \
    single_string "'" (?<!\\)(\\\\)*'        '' \
    backtick      '`' (?<!\\)(\\\\)*`        '' \
    regex         '/' (?<!\\)(\\\\)*/[imox]* '' \
    comment       '#' '$'                    '' \
    comment       ^begin= ^=end              '' \
    literal       '%[iqrswxIQRSWX]\(' \)     \( \
    literal       '%[iqrswxIQRSWX]\{' \}     \{ \
    literal       '%[iqrswxIQRSWX]\[' \]     \[ \
    literal       '%[iqrswxIQRSWX]<'   >      < \
    division '[\w\)\]](/|(\h+/\h+))' '\w' '' # Help Kakoune to better detect /…/ literals

# Regular expression flags are: i → ignore case, m → multi-lines, o → only interpolate #{} blocks once, x → extended mode (ignore white spaces)
# Literals are: i → array of symbols, q → string, r → regular expression, s → symbol, w → array of words, x → capture shell result

addhl -group /elixir/double_string fill string
addhl -group /elixir/double_string regions regions interpolation \Q#{ \} \{
addhl -group /elixir/double_string/regions/interpolation fill meta

addhl -group /elixir/single_string fill string

addhl -group /elixir/backtick fill meta
addhl -group /elixir/backtick regions regions interpolation \Q#{ \} \{
addhl -group /elixir/backtick/regions/interpolation fill meta

addhl -group /elixir/regex fill meta
addhl -group /elixir/regex regions regions interpolation \Q#{ \} \{
addhl -group /elixir/regex/regions/interpolation fill meta

addhl -group /elixir/comment fill comment

addhl -group /elixir/literal fill meta

addhl -group /elixir/code regex \b([A-Za-z]\w*:(?=[^:]))|([$@][A-Za-z]\w*)|((?<=[^:]):[A-Za-z]\w*[=?!]?)|([A-Z]\w*|^|\h)\K::(?=[A-Z]) 0:identifier

%sh{
    # Grammar
    # Keywords are collected searching for keywords at
    # https://github.com/elixir/elixir/blob/trunk/parse.y
    keywords="alias|and|begin|break|case|class|def|defined|defmodule|do|else|elsif|end"
    keywords="${keywords}|ensure|false|for|if|in|module|next|nil|not|or|redo"
    keywords="${keywords}|rescue|retry|return|self|super|then|true|undef|unless|until|use|when|while|yield"
    attributes="attr_reader|attr_writer|attr_accessor"
    values="false|true|nil"
    meta="require|include"

    # Add the language's grammar to the static completion list
    printf %s\\n "hook global WinSetOption filetype=elixir %{
        set window static_words '${keywords}:${attributes}:${values}:${meta}'
    }" | sed 's,|,:,g'

    # Highlight keywords
    printf %s "
        addhl -group /elixir/code regex \b(${keywords})\b 0:keyword
        addhl -group /elixir/code regex \b(${attributes})\b 0:attribute
        addhl -group /elixir/code regex \b(${values})\b 0:value
        addhl -group /elixir/code regex \b(${meta})\b 0:meta
    "
}

# Commands
# ‾‾‾‾‾‾‾‾

def elixir-alternative-file -docstring 'Jump to the alternate file (implementation ↔ test)' %{ %sh{
    case $kak_buffile in
        *spec/*_spec.rb)
            altfile=$(eval echo $(echo $kak_buffile | sed s+spec/+'*'/+';'s/_spec//))
            [ ! -f $altfile ] && echo "echo -color Error 'implementation file not found'" && exit
        ;;
        *.rb)
            path=$kak_buffile
            dirs=$(while [ $path ]; do echo $path; path=${path%/*}; done | tail -n +2)
            for dir in $dirs; do
                altdir=$dir/spec
                if [ -d $altdir ]; then
                    altfile=$altdir/$(realpath $kak_buffile --relative-to $dir | sed s+[^/]'*'/++';'s/.rb$/_spec.rb/)
                    break
                fi
            done
            [ ! -d $altdir ] && echo "echo -color Error 'spec/ not found'" && exit
        ;;
        *)
            echo "echo -color Error 'alternative file not found'" && exit
        ;;
    esac
    echo "edit $altfile"
}}

def -hidden _elixir_filter_around_selections %{
    eval -no-hooks -draft -itersel %{
        exec <a-x>
        # remove trailing white spaces
        try %{ exec -draft s \h + $ <ret> d }
    }
}

def -hidden _elixir_indent_on_char %{
    eval -no-hooks -draft -itersel %{
        # align middle and end structures to start
        try %{ exec -draft <a-x> <a-k> ^ \h * (else|elsif) $ <ret> <a-\;> <a-?> ^ \h * (if)                                                       <ret> s \A | \Z <ret> \' <a-&> }
        try %{ exec -draft <a-x> <a-k> ^ \h * (when)       $ <ret> <a-\;> <a-?> ^ \h * (case)                                                     <ret> s \A | \Z <ret> \' <a-&> }
        try %{ exec -draft <a-x> <a-k> ^ \h * (rescue)     $ <ret> <a-\;> <a-?> ^ \h * (begin)                                                    <ret> s \A | \Z <ret> \' <a-&> }
        try %{ exec -draft <a-x> <a-k> ^ \h * (end)        $ <ret> <a-\;> <a-?> ^ \h * (begin|case|class|def|do|for|if|module|unless|until|while) <ret> s \A | \Z <ret> \' <a-&> }
    }
}

def -hidden _elixir_indent_on_new_line %{
    eval -no-hooks -draft -itersel %{
        # preserve previous line indent
        try %{ exec -draft K <a-&> }
        # filter previous line
        try %{ exec -draft k : _elixir_filter_around_selections <ret> }
        # indent after start structure
        try %{ exec -draft k x <a-k> ^ \h * (begin|case|class|def|do|else|elsif|ensure|for|if|module|rescue|unless|until|when|while) \b <ret> j <a-gt> }
    }
}

def -hidden _elixir_insert_on_new_line %{
    eval -no-hooks -draft -itersel %{
        # copy _#_ comment prefix and following white spaces
        try %{ exec -draft k x s ^ \h * \K \# \h * <ret> y j p }
        # wisely add end structure
        eval -save-regs x %{
            try %{ exec -draft k x s ^ \h + <ret> \" x y } catch %{ reg x '' }
            try %{ exec -draft k x <a-k> ^ <c-r> x (begin|case|class|def|do|for|if|module|unless|until|while) <ret> j <a-a> i X <a-\;> K <a-K> ^ <c-r> x (begin|case|class|def|do|for|if|module|unless|until|while) . * \n <c-r> x end $ <ret> j x y p j a end <esc> <a-lt> }
        }
    }
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook -group elixir-highlight global WinSetOption filetype=elixir %{ addhl ref elixir }

hook global WinSetOption filetype=elixir %{
    hook window InsertChar .* -group elixir-indent _elixir_indent_on_char
    hook window InsertChar \n -group elixir-indent _elixir_indent_on_new_line
    hook window InsertChar \n -group elixir-insert _elixir_insert_on_new_line

    alias window alt elixir-alternative-file
}

hook -group elixir-highlight global WinSetOption filetype=(?!elixir).* %{ rmhl elixir }

hook global WinSetOption filetype=(?!elixir).* %{
    rmhooks window elixir-indent
    rmhooks window elixir-insert

    unalias window alt elixir-alternative-file
}

