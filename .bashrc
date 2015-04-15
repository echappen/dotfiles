export PS1="\d \A \W\$ " # custom prompt
# canonical -> "\h:\W \u\$ "

source ~/.git-completion.bash

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

rvm use 2.1.0

export EDITOR='vim'

# custom aliases
alias vim='mvim -v'

# CUSTOM FUNCTIONS
hello()
{
    echo "Hello $1, let us be a friend." ;
}

grepr()
{
    echo "";
    echo ""; # space things out a bit for scanning
    grep -r "$1" $2 --color -n;
    echo "";
    echo "";
    i=0
    for arg in "$@"; do
        echo "arg$i=$arg"
        let ++i
    done
}

google()
{
    open https://encrypted.google.com/#q=$1+$2+$3+$4+$5+$6+$7+$8+$9;
}

github()
{
    open https://github.com/search?q=$1+$2+$3+$4+$5+$6+$7+$8+$9;
}

myargs()
{
    i=0
    for arg in "$@"; do
        echo "arg$i=$arg"
        let ++i
    done
}