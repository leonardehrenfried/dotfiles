export PATH=/usr/local/bin:/Users/lenni/bin:/usr/local/share/npm/bin:$PATH

GEM_PATH=`gem environment|grep "EXECUTABLE DIRECTORY"|cut -d":" -f2|sed 's/^[ \t]*//'`
if [ -d $GEM_PATH ]
then
    export PATH="$PATH:$GEM_PATH"
fi

if [ -d /opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin ]
then
    export PATH="$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin"
fi

export EDITOR=vi
export MANPATH=/usr/local/share/man:$MANPATH

# ls colour output
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS='Bxcxfxfxcxdxdxhbadbxbx'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# color definitions
force_color_prompt=yes
export GREP_COLOR='1;37;41'
RS="\[\033[0m\]"    # reset
HC="\[\033[1m\]"    # hicolor
UL="\[\033[4m\]"    # underline
INV="\[\033[7m\]"   # inverse background and foreground
FBLK="\[\033[30m\]" # foreground black
FRED="\[\033[31m\]" # foreground red
FGRN="\[\033[32m\]" # foreground green
FYEL="\[\033[33m\]" # foreground yellow
FBLE="\[\033[34m\]" # foreground blue
FMAG="\[\033[35m\]" # foreground magenta
FCYN="\[\033[36m\]" # foreground cyan
FWHT="\[\033[37m\]" # foreground white
BBLK="\[\033[40m\]" # background black
BRED="\[\033[41m\]" # background red
BGRN="\[\033[42m\]" # background green
BYEL="\[\033[43m\]" # background yellow
BBLE="\[\033[44m\]" # background blue
BMAG="\[\033[45m\]" # background magenta
BCYN="\[\033[46m\]" # background cyan
BWHT="\[\033[47m\]" # background white

# prompt
function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null | wc -l) -ge 1 ]] && echo "⚡"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\n\t ${FMAG}\u ${FWHT}at ${FYEL}\h ${FWHT}in ${FGRN}\w ${FBLE}`parse_git_branch` ${FYEL}`parse_git_dirty`\
${FWHT}\n$ "

function up(){
  for i in $(seq 1 $1); do
    cd ..
  done
}

# setting the current dir as the window title
PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

AUTOJUMP=/usr/share/autojump/autojump.sh
if [ -f $AUTOJUMP ]
then
    . $AUTOJUMP
fi
# git autocomplete
COMPLETION=/usr/local/etc/bash_completion.d/git-completion.bash
if [ -f $COMPLETION ]
then
    source $COMPLETION
fi

[[ -s /usr/local/etc/autojump.sh ]] && . /usr/local/etc/autojump.sh

# host specific email address for git
# see http://lenni.info/blog/?p=510
if [ -f .host-specific.sh ]
then
    source .host-specific.sh
fi

#export these variables so that they will be sent over SSH
export GIT_AUTHOR_NAME="Leonard Ehrenfried"
export GIT_COMMITTER_NAME="Leonard Ehrenfried"

export MAVEN_OPTS=-Xmx512m

source ~/.alias
