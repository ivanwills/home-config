# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# set up my standard directories
if [ ! -d ~/bin ]; then
    mkdir ~/bin
fi
if [ ! -d ~/src ]; then
    mkdir ~/src
fi
if [ ! -d ~/log ]; then
    mkdir ~/log
fi

# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups
# don't add ls l ll bg fg or exit commands to the history list
export HISTIGNORE="&:ls:l:ll:[bf]g:exit"
export HISTSIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Check if there is a local configuration file to augment this one

if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
xterm)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
       BLACK="\[\033[0;30m\]"
        BLUE="\[\033[0;34m\]"
       GREEN="\[\033[0;32m\]"
        CYAN="\[\033[0;36m\]"
         RED="\[\033[0;31m\]"
      PURPLE="\[\033[0;35m\]"
       BROWN="\[\033[0;33m\]"
  LIGHT_GRAY="\[\033[0;37m\]"
   DARK_GRAY="\[\033[1;30m\]"
  LIGHT_BLUE="\[\033[1;34m\]"
 LIGHT_GREEN="\[\033[1;32m\]"
  LIGHT_CYAN="\[\033[1;36m\]"
   LIGHT_RED="\[\033[1;31m\]"
LIGHT_PURPLE="\[\033[1;35m\]"
      YELLOW="\[\033[1;33m\]"
       WHITE="\[\033[1;37m\]"
   NO_COLOUR="\[\033[0m\]"
PS1_SMILE="\`if [ \$? = 0 ]; then printf '\033[01;32m:-)'; else printf '\033[01;31m:-('; fi\`\[\033[00m\]"
PS1_DATE="≺$LIGHT_RED\D{%Y-%m-%d %H:%M:%S}$NO_COLOUR≻"
PS1_WORKING="\[\033[01;34m\]\w\[\033[00m\]"
if [ !$PS1_DEBIAN ]; then
    PS1_DEBIAN="${debian_chroot:+($debian_chroot)}"
fi
PS1_USER="$LIGHT_GREEN\u$NO_COLOUR"
if [ $USER == 'root' ]; then
    PS1_USER="$LIGHT_RED\u$NO_COLOUR"
fi
PS1_HOST="$BROWN\[\033[01;22m\]@$NO_COLOUR$HOST_COLOUR\h$NO_COLOUR"
PS1_JOBS="≺job: $BROWN\j/$(ps ax | wc -l)$NO_COLOUR≻"
PS1_UPTIME="≺up: $YELLOW\$(temp=\$(cat /proc/uptime) && upSec=\${temp%%.*}; let mins=\$((\${upSec}/60%60)); let hours=\$((\${upSec}/3600%24)); let days=\$((\${upSec}/86400)); echo -n \${days}d\${hours}h\${mins}m)$NO_COLOUR≻"
PS1_FILES="file:$LIGHT_CYAN\$(ls -l | /bin/grep \"^-\" | wc -l | tr -d \" \")$NO_COLOUR"
PS1_DIRS="dir:$LIGHT_CYAN\$(ls -l | /bin/grep \"^d\" | wc -l | tr -d \" \")$NO_COLOUR"
PS1_SIZE="$LIGHT_CYAN\$(ls --si -s | head -1 | awk '{print \$2}')$NO_COLOUR"
PS1_DIR="≺$PS1_WORKING $PS1_DIRS, $PS1_FILES, $PS1_SIZE≻"

case `perl -e 'print $^O'` in
linux)
    if `which app-ps1 2> /dev/null`; then
        PS1="$NO_COLOUR\[\`app-ps1 -e \$? -p 'face;branch;date;directory;perl;node;ruby;uptime'\`\]\n$PS1_DEBIAN$PS1_USER$PS1_HOST \\\$ "
    elif `which ps1 2> /dev/null`; then
        PS1="$NO_COLOUR\[\`ps1 -e \$?\`\]\n$PS1_DEBIAN$PS1_USER$PS1_HOST \\\$ "
    else
        __git_prompt () {
            pwd | perl -nle 'return if !-d $_ || !m{^/}; while (!m{^/?$} && !-f "$_/.git/HEAD") { s{/[^/]+$}{} } exit if m{^/?$}; open F, "$_/.git/HEAD"; $_=<F>; s/^.*?(\w+)\n?$/$1/; print " ($_)"'
        }

        PS1="$NO_COLOUR╭$PS1_SMILE $PS1_DATE $PS1_DIR $PS1_JOBS $PS1_UPTIME\n╰$PS1_DEBIAN$PS1_USER$PS1_HOST\$(__git_prompt) \\\$ "
    fi
    ;;
solaris)
    PS1="$NOCOLOUR$PS1_SMILE $PS1_USER$PS1_HOST \\\$ "
    ;;
*)
    PS1="$PS1_USER$PS1_HOST \\\$ "
    ;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias dir='ls --color=auto --format=vertical'
    alias vdir='ls --color=auto --format=long'
fi


# Check if this is being run as root user (eg su -m or sudo bash)
if [ -x /sbin/init ]; then
    PATH=$PATH:/usr/local/sbin
    PATH=$PATH:/usr/sbin
    PATH=$PATH:/sbin
fi

# set up history
shopt -s histappend
#export PROMPT_COMMAND='history -a'

# spell checking dirs
shopt -s cdspell

PATH=~/bin:$PATH
PATH=~/lib/bin:$PATH
if [ -e ~/bin/java/bin ]; then
    PATH=$PATH:~/bin/java/bin
fi
PATH=$PATH:/bin
PATH=$PATH:/usr/bin
PATH=$PATH:/usr/local/bin
PATH=$PATH:/opt/bin
PATH=$PATH:/opt/sbin
PATH=$PATH:/opt/perl
PATH=$PATH:/home/ivan/src/rakudo-star-2011.07/install/bin/
PATH=$PATH:~/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:./node_modules/.bin/
PATH=$PATH:~/.meteor
PATH=$PATH::~/bin/adt-bundle/sdk/platform-tools:~/bin/adt-bundle/sdk/tools
PATH=~/.rakudobrew/bin:$PATH
PATH=`perl -le '%p; print join ":", grep {!/1\.5T/} grep { s{/$}{}; !$p{$_}++ } split /\s*:\s*/, $ENV{PATH}'`
export PATH
export CDPATH='.:..:../..:~/links:~'
export VISUAL=vim
export EDITOR=vim
export PAGER='/usr/bin/less -Rx4SFX'
export PERL5LIB=~/lib/i686-linux:~/lib:~/lib/site-perl:~/lib/lib/perl5:~/lib/site-perl:~/lib/lib/perl5/site_perl/:~/lib/lib/perl5/5.8.8/
export APP_PS1='face;branch;date;directory;perl;node;ruby;uptime'

umask ug=rwx,o=rx

# New devmode helper
_devmode() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="--task -t --kill -k --list --ls -l --all -a --exists -e --multiconnect -x --create -c --chdir -d --reconnect -r --force_title -force-title -f --title_bar -title-bar -b --protect -p --short -S --server -s --auto -A --current -C --pre_cmd -pre-cmd --pre --post_cmd -post-cmd --post --test -T --verbose -v --man --help --VERSION"
    if [[ ${cur} == -* && ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
    elif [[ ${prev} == -s* ]]; then
        local hosts=$(devmode --auto ssh)
        COMPREPLY=($(compgen -W "${hosts}" -- ${cur}))
    else
        local sonames=$(devmode --auto full --current ${COMP_CWORD} ${COMP_WORDS[@]})
        COMPREPLY=($(compgen -W "${sonames}" -- ${cur}))
    fi
}
complete -F _devmode devmode

# New devmode2 helper
_devmode2() {
    COMPREPLY=()
    local sonames=$(devmode2 --auto --current "${COMP_CWORD}" -- ${COMP_WORDS[@]})
    COMPREPLY=($(compgen -W "${sonames}" -- ${COMP_WORDS[COMP_CWORD]}))
}
complete -F _devmode2 devmode2

# group-git helper
_group-git() {
    COMPREPLY=()
    local sonames=$(group-git --auto-complete --current "${COMP_CWORD}" -- ${COMP_WORDS[@]})
    COMPREPLY=($(compgen -W "${sonames}" -- ${COMP_WORDS[COMP_CWORD]}))
}
complete -F _group-git group-git

# v auto complete
_v() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=" --schema -s --max -m --test -t --tags -T --open -o --open_vertical -O --verbose -v --man --help --VERSION"

    if [[ ${cur} == -* && ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
    else
        local sonames=$(v --auto-complete ${COMP_WORDS[@]})
        COMPREPLY=($(compgen -W "${sonames}" -- ${cur}))
    fi
}
complete -F _v v

# apparently this will stop screen from hanging
tty --silent && stty -ixon -ixoff

if [ -f ~/perl5/perlbrew/etc/bashrc ]; then
    if [ `which perlbrew` ]; then
        source ~/perl5/perlbrew/etc/bashrc
    fi
fi

if [ -s $HOME/.nvm/nvm.sh ]; then
    source $HOME/.nvm/nvm.sh # This loads Node version manager
fi

if [ -s $HOME/.rvm/scripts/rvm ]; then
    source $HOME/.rvm/scripts/rvm # This loads Ruby version manager
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

if [ ! -h "/tmp/.$USER" ]; then
    if [ -d "$HOME/.undo-vim" ]; then
        ln -s $HOME/.undo-vim /tmp/.$USER
    fi
fi

if [ -x `which mvn 2> /dev/null` ]; then
    if [ -x `which tee 2> /dev/null` ]; then
        if [ -x `which tailt 2> /dev/null` ]; then
            mvn() {
                time /usr/bin/mvn $@ | tee ~/log/mvn-`pwd | perl -pe 's{.*/}{}'`.log | tailt -c liferay
            }
        fi
    fi
fi

tmw() {
    tmux split-window -dh "$*"
}

pmdebug () {

    test_path=$1

    if [ -d "$test_path" ]; then
        echo "Full path"
    else
        test_path=~/src/$1
    fi

    export PATH="$test_path/bin:$PATH"
    export PERL5LIB="$test_path/lib:$PERL5LIB"

    hash -r
}

export AUTOSSH_PORT=0

