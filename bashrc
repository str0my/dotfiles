# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    if [ -f /.dockerenv ]; then
        PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(__git_ps1)\[\033[00m\]\$ '
    elif [ "$(id -u)" = "0" ]; then
        PS1='\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(__git_ps1)\[\033[00m\]\$ '
    else
        PS1='\[\033[38;5;214m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;31m\]$(__git_ps1)\[\033[00m\]\$ '
    fi
else
    PS1='\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

__git_ps1() 
{
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return;
    echo " ["${ref#refs/heads/}"]";
}

[ -f ~/.ctfrc ] && . ~/.ctfrc

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export PATH=~/bin:$PATH
export EDITOR=vim
export PYTHONSTARTUP="$HOME/.pythonrc"
export CLICOLOR=1
export TERM=screen-256color
export PIN_ROOT="$HOME/bin/pin"

alias py="python"
alias py3="python3"
alias ..="cd .."
alias gdb="gdb -q"
alias gdbm="gdb-multiarch -q"
alias tmux="tmux -2"
alias rip="curl orange.tw"
alias tip="curl --socks5 127.0.0.1:9050 orange.tw"
alias tcurl="curl --socks5 127.0.0.1:9050 "
alias strace="strace -ixv"
alias ltrace="ltrace -iC"
alias objdump="objdump -M intel"
alias fuck="killall -9"
alias djson="python -m json.tool"
alias folders="find . -maxdepth 1 -type d -print0 | xargs -0 du -skh | sort -rn"

alias ll='ls -l'
alias la='ls -Ahl'
alias l='ls -CF'
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Less Colors for Man Pages
export PAGER="$(which less) -s"
export BROWSER="$PAGER"
export LESS_TERMCAP_mb=$'\E[38;5;167m'  # begin blinking
export LESS_TERMCAP_md=$'\E[38;5;39m'   # begin bold
export LESS_TERMCAP_me=$'\E[0m'         # end mode
export LESS_TERMCAP_se=$'\E[38;5;231m'  # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;167m'  # begin standout-mode - info box
export LESS_TERMCAP_us=$'\E[38;5;167m'  # begin underline
export LESS_TERMCAP_ue=$'\E[0m'         # end underline

# ssh auto complete
complete -W "$(cat ~/.ssh/known_hosts 2>&1|  cut -f 1 -d ' ' | sed -e s/,.*//g | grep -v '^#' |  uniq | grep -v '\[';\
               cat ~/.ssh/config 2>&1| grep '^Host ' | grep -v '*' |  awk '{print $2}')" ssh

# virtualenvwrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=~/.env
    source /usr/local/bin/virtualenvwrapper.sh
fi

function tunnel()
{
    if [ $# != 4 ]; then
        echo "tunnel <LOCAL PORT> <DEST HOST> <DEST PORT> <host>"
    else
        ssh -NfL $1:$2:$3 $4
    fi
}

function docker-shell()
{
    docker exec -it $1 /bin/bash
}

#
# Uncompresses raw zlib compressed data.
#
# usage: unzlib [files]
#
# example: curl http://127.0.0.1/raw_zlib_stuff | unzlib
#          unzlib .git/objects/*/*
#
unzlib() {
  if [ $# -eq 0 ]; then
    # read from stdin
    cat <(printf "\x1f\x8b\x08\x00\x00\x00\x00\x00") - | gzip -dcq
    return 0
  fi

  for file in "$@"; do
    if [ $# -gt 1 ]; then
      if [ $file != $1 ]; then
        # print newline
        echo "\n"
      fi
      echo ">>>> $file <<<<"
    fi

    # add gzip magic and pipe to gunzip
    printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" | cat - $file | gzip -dcq
  done
}

#
# Extract various archive formats
#
# usage: extract <file>
#
extract() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.tar.xz)    tar xJf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#
# Highlights every occurande of the search pattern while displaying the whole content
#
# usage: cmd | hlgrep search_pattern
#        hlgrep search_pattern file
#
hlgrep() {
  grep -E "$|$1" --color $2
}

#
# Interface to the OS clipboard (Linux only)
#
# usage: clip           # show clipboard content
#        clip <file>    # copy file content to clipboard
#        cmd | clip     # copy output of cmd to clipboard
#
clip() {
  if [[ -t 0  && -z "$1" ]]; then
    # output contents of clipboard
    xclip -out -selection clipboard
  elif [[ -n "$1" ]]; then
    # copy file contents to clipboard
    xclip -in -selection clipboard < "$1"
  else
    # read from stdin
    xclip -in -selection clipboard
  fi
}

#
# cat with syntax highlighting
#
# usage: scat file1 file2 ...
#
scat() {
  for arg in "$@"; do
    pygmentize -g "$arg" 2> /dev/null || cat "$arg"
  done
}

#
# Create a new directory and cd into it
# Similar to "mkdir xxx && cd $_"
#
mkcd() {
  if [ ! -n "$1" ]; then
    echo "Enter a directory name"
  elif [ -d $1 ]; then
    echo "\`$1' already exists"
  else
    mkdir $1 && cd $1
  fi
}

#
# Share files using transfer.io
#
# Uploads the provided file or data (if being piped to) to https://transfer.sh and puts the resulting URL into the OS clipboard.
#
# usage:
#   transfer <file>
#   some_command | transfer filename.txt
#
#
#
#
transfer() {
	if [ $# -eq 0 ]; then
		echo "No arguments specified. Usage:\ntransfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
		return 1
	fi

	file=$1
	tmpfile=$(mktemp -t transferXXX)
	basefile=$(basename "$file" | sed -e 's/[^a-zA-Z0-9._-]/-/g')

	if [ -t 0 ]; then
		# stdin is a terminal, so assume the user wants to upload a local file/directory (as opposed to piping the data to this function).
		if [ ! -e $file ]; then
			echo "File $file doesn't exists."
			return 1
		fi

		if [ -d $file ]; then
			# zip directory content and transfer.
			zipfile=$(mktemp -t transferXXX.zip)
			cd $(dirname $file) && zip -r -q - $(basename $file) >> $zipfile
			curl --progress-bar --upload-file "$zipfile" "https://transfer.sh/$basefile.zip" >> $tmpfile
			rm -f $zipfile
		else
			# transfer file.
			curl --progress-bar --upload-file "$file" "https://transfer.sh/$basefile" >> $tmpfile
		fi
	else
		# stdin is not a terminal. Presumably someone is piping something to us, so upload that.
		curl --progress-bar --upload-file - "https://transfer.sh/$basefile" >> $tmpfile
	fi

	cat $tmpfile
	# Put resulting URL (without trailing whitespace) into the OS clipboard (OS X only)
	cat $tmpfile | tr -d '\n\r' | pbcopy
	rm -f $tmpfile
}

gui(){
	nohup $@ &>/dev/null &
}

