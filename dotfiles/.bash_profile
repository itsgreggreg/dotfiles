# put bash into vi mode
set -o vi

# put source files in path
export PATH=~/.dotfiles/pathfiles:$PATH

# rbenv
export PATH=~/.rbenv/shims:$PATH

# Beets with config in home
alias beet='beet -c ~/.beets_config.yaml'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# Android dev
export PATH=~/Developer/android-sdk-macosx/tools:$PATH
export PATH=~/Developer/android-sdk-macosx/platform-tools:$PATH

# Sencha
export PATH=/Users/greggreg/Developer/Sencha/Cmd/4.0.4.84:$PATH
export SENCHA_CMD_3_0_0="/Users/greggreg/Developer/Sencha/Cmd/4.0.4.84"
