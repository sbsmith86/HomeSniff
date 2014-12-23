
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

## PATH ##
export PATH=$PATH:/home/user/bin
 
## Git Stuff ##
function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
 
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
NO_COLOR="\[\033[0m\]"
 
PS1="$GREEN\u@\h$NO_COLOR:\w$YELLOW\$(parse_git_branch)$NO_COLOR\$ "
 
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
 
## DoSomething Commands ##
eval "$(rbenv init -)"
nsync() {
  cd $HOME/Projects/neue
  grunt build
 
  rm -rf $HOME/Projects/dosomething-mount/lib/themes/dosomething/paraneue_dosomething/bower_components/neue
  mkdir $HOME/Projects/dosomething-mount/lib/themes/dosomething/paraneue_dosomething/bower_components/neue
  
  cp -r assets $HOME/Projects/dosomething-mount/lib/themes/dosomething/paraneue_dosomething/bower_components/neue
  cp -r dist $HOME/Projects/dosomething-mount/lib/themes/dosomething/paraneue_dosomething/bower_components/neue
  cp -r scss $HOME/Projects/dosomething-mount/lib/themes/dosomething/paraneue_dosomething/bower_components/neue
  cp -r js $HOME/Projects/dosomething-mount/lib/themes/dosomething/paraneue_dosomething/bower_components/neue
 
  cd -
 
  echo "\e[42m\e[30m ✓ Built dist package and copied into DS app."
}
 
gsync() { 
  git fetch upstream && git checkout dev && git rebase upstream/dev && git push origin dev
 }
 
handleit() {
  cd ../dosomething
  diskutil unmount force ../dosomething-mount
  vagrant up
  cd ../dosomething-mount
}