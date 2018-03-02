export PATH="/Users/brad/anaconda3/bin:$PATH"
export PATH="/Library/PostgreSQL/10/bin:$PATH"

export GOPATH="$HOME/Scripts/go"

# All Apache-Spark-related
export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"
export SPARK_HOME="/usr/local/Cellar/apache-spark/2.2.1/libexec"
export PYSPARK_PYTHON="/Users/brad/anaconda3/bin/python3"
export PYTHONPATH="/Users/brad/anaconda3/lib/python3.6"
export PYTHONPATH="$SPARK_HOME/python/:$PYTHONPATH"
export SCALA_HOME="/usr/local/bin/scala"

export HADOOP_HOME="/usr/local/Cellar/hadoop/3.0.0/libexec"
export HADOOP_CONF_DIR="$HADOOP_HOME/etc/hadoop"


# shorten bash prompt
PS1="\e[0;32m \W$ \e[m"

alias lah="ls -lahFG"
alias resize="printf '\e[8;40;80t'; clear"
alias small="printf '\e[8;20;70t'; clear"
alias cdpy="cd /Users/brad/Scripts/python/"
alias cdsite="cd /Users/brad/anaconda3/lib/python3.6/site-packages/"
alias cdnyc="cd /Users/brad/Scripts/python/metis/metisgh/nyc18_ds14/"

# Change to a directory, and list its contents
cdls() {
    cd $1
    ls
}

# Turn off blank git commit message prompt
export GIT_MERGE_AUTOEDIT=no
