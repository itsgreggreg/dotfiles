
hook global BufCreate .*[.](css|scss|js) %{
  set buffer formatcmd "prettier --stdin --stdin-filepath=$kak_buffile"
}
hook global BufWritePre .+\.(css|scss|js) %{ format }



