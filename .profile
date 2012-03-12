export PATH=/usr/local/bin:/Users/lenni/bin:$PATH

if [ -d /usr/local/Cellar/ruby/1.9.3-p125/bin ]
then
    export PATH="$PATH:/usr/local/Cellar/ruby/1.9.3-p125/bin"
fi

if [ -d /opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin ]
then
    export PATH="$PATH:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin"
fi

export PYTHONPATH=/Users/lenni/dev/python-lib:/Users/lenni/dev/edd/:$PYTHONPATH
export DJANGO_SETTINGS_MODULE=edd.settings
export EDITOR=vi

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

