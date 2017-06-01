#def elm-format -docstring "Passes the contents of the file through elm-format" %{
  #exec '%'|elm-format\ --stdin\ 2\>\&1<ret>g.
#}

hook global BufCreate .*[.](elm) %{
  set buffer formatcmd "elm-format --stdin 2>&1"
}
hook global BufWritePre .+\.elm %{ format }
