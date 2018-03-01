
export PATH="/Users/brad/anaconda3/bin:$PATH"
export PATH="/Library/PostgreSQL/10/bin:$PATH"
export GOPATH="$HOME/Scripts/go"
export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"

# shorten bash prompt
PS1="\e[0;32m \W$ \e[m"

alias lah="ls -lahFG"
alias resize="printf '\e[8;40;80t'; clear"
alias small="printf '\e[8;20;70t'; clear"
alias cdpy="cd /Users/brad/Scripts/python/"
alias cdsite="cd /Users/brad/anaconda3/lib/python3.6/site-packages/"

# Change to a directory, and list its contents
cdls() {
    cd $1
    ls
}

# Turn off blank git commit message prompt
export GIT_MERGE_AUTOEDIT=no
