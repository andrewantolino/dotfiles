# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
HOMEBREW_PREFIX=$(brew --prefix 2>/dev/null || echo "/opt/homebrew")

#################
## ZSH PLUGINS ##
#################

## AUTOCOMPLETE ##
# Add zsh-completions to fpath
if type brew &>/dev/null; then
  FPATH="$HOMEBREW_PREFIX/share/zsh-completions:$FPATH"
fi
autoload -Uz compinit && compinit

## AUTOSUGGESTIONS ##
if [[ -f $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
fi

## SYNTAX HIGHLIGHTING ##
# Must be sourced at the end
if [[ -f $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

## HISTORY SUBSTRING SEARCH ##
if [[ -f $HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
  source $HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh
  # Bind up/down arrow keys
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi

############
## PROMPT ##
############

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
precmd_vcs_info() { 
  vcs_info
  GIT_PROMPT_INFO=
  # If in a git repo, show info
  if [[ ! -z ${vcs_info_msg_0_} ]]; then
    # {gitIcon} {gitBranch} {branchStatus}
    # TODO
    # - Dirty tree indicator (*)
    #  - Does this need to cater for unstaged and staged changes?
    # - Changes to push/pull indicator (up/down arrows: )
    GIT_PROMPT_INFO="%F{green}$(echo '\ue725') ${vcs_info_msg_0_}%f"
  fi
}
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

AWS_PROMPT_INFO=
if [[ ! -z $AWS_PROFILE ]]; then
  AWS_PROMPT_INFO="%F{yellow}$(echo '\ue268') ${AWS_PROFILE}%f "
fi

# {workingDir} {awsProfile}
PROMPT='%F{blue}%3~%f ${AWS_PROMPT_INFO}%(?.%F{magenta}%(!.#.❯)%f .%F{red}%(!.#.❯)%f '
RPROMPT='${GIT_PROMPT_INFO}'
zstyle ':vcs_info:git:*' formats '%b'

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
alias gwp="git worktree prune"
alias glog="git log --all --decorate --oneline --graph"

# Create worktree with new branch

function gwab {
  # Should be run from `main` branch
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

setopt extended_history
HISTFILE=~/.zsh_history
SAVEHIST=100000
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
HIST_STAMPS="${TIMESTAMP}"

############
## DIRENV ##
############
eval "$(direnv hook zsh)"

############
### RUBY ###
############
eval "$(rbenv init - zsh)"

# pnpm
export PNPM_HOME="/Users/andrew-antolino/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

############
### MISE ###
############
eval "$(mise activate zsh)"

############
### JAVA ###
############
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
