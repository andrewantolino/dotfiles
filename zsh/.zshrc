# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

#################
## ZSH PLUGINS ##
#################

ZSH_HOME="$HOME/.zsh"
PLUGINS_DIR="$ZSH_HOME/plugins"
PROMPT_DIR="$ZSH_HOME/prompt"

## AUTOCOMPLETE $$
# Append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# Initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

## SYNTAX HIGHLIGHTING ##
source $PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

############
## PROMPT ##
############

fpath+=($HOME/.zsh/prompt/pure)
autoload -U promptinit; promptinit
prompt pure

#############
## ALIASES ##
#############

alias ll="ls -l"
alias la="ls -la"
alias gc="git checkout"
alias gb="git checkout -b"
alias ga="git add"
alias gcm="git commit -m"
alias grb="git rebase"
alias gm="git merge"
alias gwa="git worktree add"
alias gwr="git worktree remove"
alias gwl="git worktree list"

############
## EDITOR ##
############
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code'
fi

#########
## AWS ##
#########
export AWS_REGION=us-east-1
export AWS_DEFAULT_REGION=us-east-1
# Ensure AWS SDK uses config for profile region etc
export AWS_SDK_LOAD_CONFIG=1

# Alias to switch AWS profile and populate temporary credentials
alias awssso='source assume $1 --export'

# Function to assume and open AWS Profile in the console
aws-console() {
	assume -c $1 -s $2;
}

##########
## ASDF ##
##########
. "$HOME/.asdf/asdf.sh"
setopt extended_history
HISTFILE=~/.zsh_history
SAVEHIST=100000
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
HIST_STAMPS="${TIMESTAMP}"
