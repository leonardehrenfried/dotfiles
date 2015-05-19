# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/data/home/lehrenfried/.zshrc'

# End of lines added by compinstall
setopt prompt_subst
setopt correct
setopt append_history share_history histignorealldups
setopt appendhistory autocd extendedglob nomatch notify

autoload -U colors && colors
autoload -Uz vcs_info
autoload compinit && compinit

# arrow up will search through history
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '\eOA' up-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search
bindkey '\eOB' down-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search

export PATH=~/bin:~/.cabal/bin:/usr/local/bin:/Users/lenni/bin:/usr/local/share/npm/bin:/sbin:$PATH

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

source ~/.alias

zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●%f'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{red}:%f%F{yellow}%r%f'
zstyle ':vcs_info:*' enable git

precmd () {
  if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
    zstyle ':vcs_info:*' formats '%F{blue}(%b%c) %u%f%F{blue}%f'
  } else {
    zstyle ':vcs_info:*' formats '%F{blue}(%b%c%u%f%F{red}) ●%f%F{blue}]%f'
  }
  vcs_info
}

### Needed for a pretty prompt
setopt prompt_subst # Enables additional prompt extentions

PROMPT='
%D{%H:%M:%S}%f %(!.%B%U%F{e}%n%f%u%b.%F{magenta}%n%f) at %F{yellow}%m%f in %F{green}%~%f ${vcs_info_msg_0_} %(!.%F{red}%f.)
%{$reset_color%}$ '
### My default prompt's right side
#RPROMPT='${vcs_info_msg_0_} %(!.%F{red}%f.)'

### My prompt for loops
PROMPT2='{%_}  '

### My prompt for selections
PROMPT3='{ … }  '

### So far I don't use "setopt xtrace", so I don't need this prompt
#PROMPT4=''
