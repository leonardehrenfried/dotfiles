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

export PYTHONPATH=/Users/lenni/dev/python-lib:/Users/lenni/dev/edd/:$PYTHONPATH
export EDITOR=vi
export MANPATH=/usr/local/share/man:$MANPATH

# ls colour output
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS='Bxcxfxfxcxdxdxhbadbxbx'

# color definitions
D=$'\e[37;40m'
PINK=$'\e[35;40m'
GREEN=$'\e[32;40m'
ORANGE=$'\e[33;40m'
RED=$'\e[0;31m'
CYAN=$'\e[0;36m'

# prompt
function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1='\n\t ${PINK}\u ${D}at ${ORANGE}\h ${D}in ${GREEN}\w ${CYAN}`parse_git_branch`\
${D}\n$ '

# setting the current dir as the window title
PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

# git autocomplete
COMPLETION=/usr/local/etc/bash_completion.d/git-completion.bash
if [ -f $COMPLETION ]
then
    source $COMPLETION
fi

# host specific email address for git
# see http://lenni.info/blog/?p=510
if [ -f .host-specific.sh ]
then
    source .host-specific.sh
fi

#export these variables so that they will be sent over SSH
export GIT_AUTHOR_NAME="Leonard Ehrenfried"
export GIT_COMMITTER_NAME="Leonard Ehrenfried"
export GIT_AUTHOR_EMAIL=$EMAIL
export GIT_COMMITTER_EMAIL=$EMAIL

export MAVEN_OPTS=-Xmx512m

os=`uname`
command="ls -lah"
if [ "$os" == "Linux" ]
then
  alias ll="$command --color"
fi

if [ "$os" == "Darwin" ]
then
  alias ll="$command"
fi
alias jsonpretty='python -mjson.tool'
