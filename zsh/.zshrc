# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

#################
## ZSH PLUGINS ##
#################

PLUGINS_DIR="$HOME/.zsh/plugins"

## AUTOCOMPLETE ##
# Append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# Initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

## SYNTAX HIGHLIGHTING ##
source $PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
