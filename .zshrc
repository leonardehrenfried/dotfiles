# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=15000
SAVEHIST=15000

unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/data/home/lehrenfried/.zshrc'

# End of lines added by compinstall
setopt prompt_subst
setopt correct
setopt append_history share_history histignorealldups
setopt appendhistory autocd nomatch notify

autoload -U colors && colors
autoload compinit && compinit

# ls colors and menu completion
export LSCOLORS='Bxcxfxfxcxdxdxhbadbxbx'
zmodload -a colors
zmodload -a autocomplete
zmodload -a complist
zstyle ':completion:*:default' list-colors ${(s.:.)LSCOLORS}
zstyle ':completion:*' menu select

# arrow up will search through history
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '\eOA' up-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search
bindkey '\eOB' down-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search

export PATH=~/bin:~/.cabal/bin:/usr/local/bin:/Users/lenni/bin:/usr/local/share/npm/bin:/sbin:~/.local/bin:~/.cargo/bin:~/.local/bin:$PATH

if [[ "$os" == "Darwin" ]]
then
  [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh > /dev/null
fi

. /usr/share/autojump/autojump.zsh > /dev/null

lw=(~/.env ~/.alias ~/.secrets)



for i in $lw; do
  source $i &> /dev/null
done

autoload -U promptinit; promptinit
prompt pure


source /home/lenni/.config/broot/launcher/bash/br

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
