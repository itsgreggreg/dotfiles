def elm-format -docstring "Passes the contents of the file through elm-config" %{
  exec '%'|elm-format\ --stdin<ret>g.
}
