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
export LC_CTYPE='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# color definitions
export GREP_COLOR='1;37;41'
D=$'\e[37;40m'
PINK=$'\e[35;40m'
GREEN=$'\e[32;40m'
ORANGE=$'\e[33;40m'
YELLOW=$'\e[0;33m'
RED=$'\e[0;31m'
CYAN=$'\e[0;36m'

# prompt
function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null | wc -l) -ge 1 ]] && echo "⚡"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1='\n\t ${PINK}\u ${D}at ${ORANGE}\h ${D}in ${GREEN}\w ${CYAN}`parse_git_branch` ${YELLOW}`parse_git_dirty`\
${D}\n$ '

function up(){
  for i in $(seq 1 $1); do
    cd ..
  done
}

# setting the current dir as the window title
PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

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
