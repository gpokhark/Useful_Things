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

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

# Show git branch name if it is git repository
function parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\n\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\n\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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

# Start CUDA Toolkit path exprt
export PATH=/usr/local/cuda-10.1/bin:/usr/local/cuda-10.1/NsightCompute-2019.1${PATH:+:${PATH}}
# End CUDA Toolkit

export NOCONDA_PATH=$PATH
# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/gaurav/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/gaurav/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/gaurav/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/gaurav/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

# <<< ROS initialize <<<
# For ROS setup you will have to remove the conda from path
while true
do

# Allow for ROS source choice
read -p "Do you want to source ROS in this workspace (y/n): " input_choice

if [ "$input_choice" = "y" ]
then
  source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash
  echo "ROS sourced!"
  # Source ROS
  export PATH=$NOCONDA_PATH
  export ROS_MASTER_URI=http://192.168.0.164:11311
  export ROS_HOSTNAME=192.168.0.164
  source /opt/ros/humble/setup.bash
  # Change ROS editor to nano
  export EDITOR='nano -w'
  # Set up ROS ip
  # export ROS_IP=`echo $(hostname -I)` 
  ########################################################################################
  # If you want to source your setup bash in your catkin workspace, uncomment the line below
  # source ~/catkin_ws/devel/setup.bash
  ########################################################################################
  # Add other ROS statements here or uncomment the relevant ones below
  # export GAZEBO_MODEL_PATH=~/catkin_ws/src/sensor_stick/models
  # export GAZEBO_MODEL_PATH=~/catkin_ws/src/RoboND-Kinematics-Project/kuka_arm/models
  ########################################################################################
  break
elif [ "$input_choice" = "n" ]
then
  echo "ROS *NOT* sourced!"
  # Setup conda
  
  break
else
  echo "Warning: Not an acceptable option. Choose (y/n).
          "
fi

done
# <<< ROS initialize <<<

# <<< conda initialize <<<
# added by Miniconda3 4.3.11 installer
# export PATH="/home/gaurav/miniconda3/bin:$PATH"
export PATH=$NOCONDA_PATH
#export PATH="/home/gaurav/miniconda3/bin:$PATH"

# >>> miniconda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/gaurav/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/gaurav/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/gaurav/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/gaurav/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

