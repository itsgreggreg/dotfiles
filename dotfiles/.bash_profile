# put bash into vi mode
set -o vi

# put source files in path
export PATH=~/.dotfiles/pathfiles:$PATH

# rbenv
export PATH=~/.rbenv/shims:$PATH

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
