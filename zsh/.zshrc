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
alias gcb="git checkout -b"
alias gb="git branch"
alias ga="git add"
alias gcm="git commit -m"
alias grb="git rebase"
alias gm="git merge"
alias gwa="git worktree add"
alias gwr="git worktree remove"
alias gwl="git worktree list"

# Create worktree with new branch

function gwab {
  # Should be run from `main` branch or better yet bare repo
  # Validate input
  #   $1 = Worktree dir name
  #   $2 = Branch name
  local worktree_dir=$1
  local new_branch=$2
  if [ $# -eq 0 ] || [ -z $2 ]
    then
      echo "Usage: $0 directory branch"
      return 1
  fi
  
  # Create new branch but don't checkout
  gb $new_branch
  gwa $worktree_dir $new_branch
}

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

############
## DIRENV ##
############
eval "$(direnv hook zsh)"
