**What**  
Symlink all the files in `~/.dotfiles/dotfiles` to `~/`

**How**
 - `git clone https://github.com/itsgreggreg/dotfiles.git ~/.dotfiles`
 - add your dotfiles to ~/.dotfiles/dotfiles
 - `ruby ~/.dotfiles/script/link.rb`
 - anytime you add a new dotfile just run link again

**Bonus**  
Make master your base set of dotfiles.  
Make branches computer specific.  
Checkout the greggreg remote branch for my crappy dotfiles.
