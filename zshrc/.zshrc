## Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

ZSH_THEME="powerlevel10k/powerlevel10k"

# Which plugins would you like to load?

plugins=(git
   zsh-autosuggestions
   zsh-syntax-highlighting
   web-search
   )

source $ZSH/oh-my-zsh.sh

# Aliases

alias st='sudo subl '
alias zshconf='sudo subl ~/.zshrc'
alias wtconf='sudo subl ~/.config/wezterm/wezterm.lua'
alias tmuxconf='sudo subl ~/.config/tmux/tmux.conf'
alias tmuxconfr='sudo subl ~/.config/tmux/tmux.reset.conf'
eval "$(zoxide init zsh)" # ---- Zoxide (better cd) ----
alias cd="z" # ---- Zoxide (better cd) ----
alias l="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2  --icons --git"
alias cat='batcat '
alias sai='sudo apt install '

# SEC STUFF

alias prepnotes='mkdir enum exploit privesc'
alias nm="nmap -sC -sV -oN nmap"
alias recon='sudo autorecon '
#alias recon=' sudo autorecon --dirbuster.tool gobuster '
alias scan='rustscan --ulimit 5000 -a' 
alias clean='sed "s/\x1b\[[0-9;]*m//g"'
alias ehosts='cd; cd /etc; sudo subl hosts'

#alias gobust='gobuster dir --wordlist ~/security/wordlists/diccnoext.txt --wildcard --url'
#alias dirsearch='python dirsearch.py -w db/dicc.txt -b -u'
#alias massdns='~/hacking/tools/massdns/bin/massdns -r ~/hacking/tools/massdns/lists/resolvers.txt -t A -o S bf-targets.txt -w livehosts.txt -s 4000'
#alias server='python -m http.server 4445'
#alias tunnel='ngrok http 4445'
#alias fuzz='ffuf -w ~/hacking/SecLists/content_discovery_all.txt -mc all -u'
#alias gr='~/go/src/github.com/tomnomnom/gf/gf' 


# fzf

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Set up fzf key bindings and fuzzy completion

source <(fzf --zsh)


# setup fzf theme 

fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"


# Use fd instead of fzf 

export FZF_DEFAULT_COMMAND="fdfind --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fdfind --type=d --hidden --strip-cwd-prefix --exclude .git"


# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.

_fzf_compgen_path() {
  fdfind --hidden --exclude .git . "$1"
}


# Use fd to generate the list for directory completion

_fzf_compgen_dir() {
  fdfind --type=d --hidden --exclude .git . "$1"
}

source ~/fzf-git.sh/fzf-git.sh


show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else batcat -n --color=always --line-range :500 {}; fi"


export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"


# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.


_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}


# Bat (better cat)

export BATCAT_THEME=Dracula


# pipx

export PATH="$PATH:/home/rene/.local/bin"
