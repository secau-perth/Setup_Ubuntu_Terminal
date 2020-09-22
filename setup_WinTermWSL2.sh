#! /bin/bash

# echo 'export PS1="[\t] ubuntu20:\w\$ "' >> ~/.bashrc


# Make the basic promt look a little different
cat <<EOF >> ~/.bashrc
# ANSI color codes
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


if [ "\$color_prompt" = yes ]; then
    PS1='\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\\$ '
else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1="\$HC\$FYEL[ \$FBLE\${debian_chroot:+(\$debian_chroot)}\u\$FYEL: \$FBLE\w \$FYEL]\\\$ \$RS"
    PS2="\$HC\$FYEL&gt; \$RS"
fi
EOF



# install Oh My Zosh
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" 
sudo apt-get install -y fonts-powerline

# Make sure git is installed
sudo apt install -y git

# Set some git credentials
read -p 'git username: ' uservar
git config --global user.name "$uservar"
read -p 'git email: ' emailvar
git config --global user.email "$emailvar"
read -sp 'git password: ' passvar
git config --global user.password "$passvar"
# cache these vars for 12 hours
git config --global credential.helper cache --timeout=43200

# Use the power10k theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k


# Install Anaconda, follow the prompts
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh

echo " the current user is: $USER"
export PATH=/home/$USER/miniconda3/bin:$PATH

# set PATH so it includes miniconda's bin

cat <<EOF >> ~/.bashrc
if [ -d "\$HOME/miniconda3/bin" ]; then
    PATH="\$HOME/miniconda3/bin:\$PATH"
fi
EOF

echo
echo " You're almost done"
echo " Open ~/.zshrc and change the ZSH_THEME variable to"
echo " 'powerlevel10k/powerlevel10k' inplace of 'robbyrussell', then follow the instructions"
echo
