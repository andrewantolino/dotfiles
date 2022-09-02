# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/andrew-antolino/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="hyperzsh"
ZSH_THEME="spaceship"

# Edit path elements
SPACESHIP_AWS_SHOW=false

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=/Users/andrew-antolino/.oh-my-zsh/custom

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  node
  npm
  kubectl
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Aliases
alias py="python3"
alias k="kubectl"
# alias kcd="kubectl config set-context $(kubectl config current-context) --namespace "
alias kc="kubectx"
alias kns="kubens"
alias ll="ls -l"
alias la="ls -la"
alias aws-login="aws-mfa \
--duration 28800 \
--device arn:aws:iam::244548702244:mfa/andrew-antolino@pluralsight.com \
--profile 471783780157_AdminPermissionSet"
alias aws-sso=~/aws-sso-credentials/awssso

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(direnv hook zsh)"

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
PATH=~/.acg/bin/:$PATH
PATH=~/.local/bin/:$PATH

export CERTIFICATE_BUNDLE=$HOME/Downloads/zscaler_root_ca_bundle.pem
export REQUESTS_CA_BUNDLE=$CERTIFICATE_BUNDLE
export CURL_CA_BUNDLE=$CERTIFICATE_BUNDLE
export NODE_EXTRA_CA_CERTS=$CERTIFICATE_BUNDLE
export AWS_CA_BUNDLE=$CERTIFICATE_BUNDLE
export SSL_CERT_FILE=$CERTIFICATE_BUNDLE

## Use AWS SSO to create daily credentials for shell sessions
sso () {
  SSO_TOOL_PATH=~/aws-sso-credentials/awssso
  if [ "$1" = "login" ]; then
    command $SSO_TOOL_PATH --all --login
  else
    command $SSO_TOOL_PATH --profile $1 --use-default
    export AWS_PROFILE=$1
    export AWS_DEFAULT_PROFILE=$1
  fi
}

# Global AWS Config
export AWS_REGION=us-east-1
export AWS_DEFAULT_REGION=us-east-1

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/andrew-antolino/git/school/ui-fragments/study-plan-ui/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/andrew-antolino/git/school/ui-fragments/study-plan-ui/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/andrew-antolino/git/school/ui-fragments/study-plan-ui/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/andrew-antolino/git/school/ui-fragments/study-plan-ui/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/andrew-antolino/git/school/backend/services/organisation-invitation/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/andrew-antolino/git/school/backend/services/organisation-invitation/node_modules/tabtab/.completions/slss.zsh
alias config='/usr/bin/git --git-dir=/Users/andrew-antolino/.cfg/ --work-tree=/Users/andrew-antolino'
