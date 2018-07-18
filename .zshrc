# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/hota/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="amuse"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# Miniconda
. /usr/local/miniconda3/etc/profile.d/conda.sh
conda activate

bindkey "^p" history-beginning-search-backward
bindkey "^n" history-beginning-search-forward

# Golang
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin



# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/hota/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/hota/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/hota/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/hota/google-cloud-sdk/completion.zsh.inc'; fi
