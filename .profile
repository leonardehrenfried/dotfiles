
# MacPorts Installer addition on 2009-07-01_at_19:30:18: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:/Users/lenni/bin:/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH

export PYTHONPATH=/Users/lenni/dev/python-lib:/Users/lenni/dev/edd/:$PYTHONPATH
export DJANGO_SETTINGS_MODULE=edd.settings
export EDITOR=vi


D=$'\e[37;40m'
PINK=$'\e[35;40m'
GREEN=$'\e[32;40m'
ORANGE=$'\e[33;40m'

export PS1='\n\t ${PINK}\u ${D}at ${ORANGE}\h ${D}in ${GREEN}\w\
${D}\n$ '

export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS='Bxcxfxfxcxdxdxhbadbxbx'


if [ -f .host-specific.sh ] 
then 
    source .host-specific.sh
fi
