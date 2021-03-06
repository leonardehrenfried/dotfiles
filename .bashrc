source .env
source .alias

# ls colour output
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS='Bxcxfxfxcxdxdxhbadbxbx'

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
parse_git_dirty() {
  [[ $(git status --porcelain 2> /dev/null | wc -l) -ge 1 ]] && echo "⚡"
}
parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

parse_git_tag () {
  git describe --tags 2> /dev/null
}

parse_git_branch_or_tag() {
  local OUT="$(parse_git_branch)"
  if [ "$OUT" == "((no branch))" ]; then
    OUT="($(parse_git_tag))";
  fi
  echo $OUT
}

PS1="\n\t ${FMAG}\u ${FWHT}at ${FYEL}\h ${FWHT}in ${FGRN}\w ${FBLE}\$(parse_git_branch_or_tag) ${FYEL}\$(parse_git_dirty)\
${FWHT}\n$ "

function up(){
  for i in $(seq 1 $1); do
    cd ..
  done
}

# setting the current dir as the window title
PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

# source files if they exist
declare -a files=(/usr/share/autojump/autojump.sh
                  /usr/local/etc/autojump.sh
                  /usr/local/etc/bash_completion.d/git-completion.bash
                  /etc/bash_completion.d/git
                  .secrets)

for i in "${files[@]}"
do
  if [ -f $i ]
  then
    source $i
  fi
done

#export these variables so that they will be sent over SSH
export GIT_AUTHOR_NAME="Leonard Ehrenfried"
export GIT_COMMITTER_NAME="Leonard Ehrenfried"

export MAVEN_OPTS=-Xmx512m

export ANDROID_HOME=/usr/local/Cellar/android-sdk/23.0.2/
export ANDROID_SDK=/usr/local/Cellar/android-sdk/23.0.2/



source /home/lenni/.config/broot/launcher/bash/br
