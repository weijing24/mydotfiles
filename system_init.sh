OS_RELEASE=$(uname)

###############################################################
# => This section is for zsh
###############################################################
# set zsh as default shell
echo "++++++++++ change shell to zsh ++++++++++"
chsh -s /bin/zsh

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp ~/.zshrc ~/.zsh_origin


###############################################################
# => This section is for custom config
###############################################################
# clone my config
echo "+++++++++ clone all config +++++++++"
cd ~ && git clone git@github.com:weijing24/mydotfiles.git && cd ~/mydotfiles
for file in `ls | grep -v README.md | grep -v macbook_init.sh`;do
	ln -s ~/mydotfiles/$file ~/.${file}
#        if [[ -f $file ]];then
#                cp $file ~/.${file}
#        elif [[ -d $file ]];then
#                cp -r $file ~/.${file}
#        else
#                echo "$file is not a file or dir"
#        fi
done

###############################################################
# => This section is for mac
###############################################################
# Install brew
if [ $OS_RELEASE = "Darwin" ];then
    # set hostname
    echo "++++++++++ change hostname and computername ++++++++++"
    sudo scutil --set HostName MacBook-Pro
    # scutil --set LocalHostName MacBook-Pro
    sudo scutil --set ComputerName Jims-MacBook-Pro

    echo "+++++++++ install brew +++++++++"
    . ~/.zshrc > /dev/null 2>&1
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # Install some software
    echo "+++++++++ install software +++++++++"
    brew tap homebrew/cask-fonts homebrew/dupes
    brew install tmux wget axel telnet minio/stable/mc autojump jq bat fzf diff-so-fancy m-cli ripgrep gnu-sed binutils watch fx mycli iproute2mac fswatch coreutils exa neofetch awscli awslogs tldr reattach-to-user-namespace
    brew cask install iina font-hack-nerd-font glance qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize cronnix switchhosts openinterminal
# 不常用
# brew cask install dbeaver-community Sloth kap adoptopenjdk/openjdk/adoptopenjdk8 mos osxfuse ntfs-3g mounty
# ntfs
#sudo mv /sbin/mount_ntfs /sbin/mount_ntfs.bak
#sudo ln -s /usr/local/sbin/mount_ntfs /sbin/mount_ntfs
fi

###############################################################
# => This section is for ubuntu
###############################################################
if [ $OS_RELEASE = "Linux" ];then
    echo "+++++++++ install software +++++++++"
    apt install -y docker.io autojump inotify-tools
    echo "======= install bat ========"
    cd ~ && wget https://github.com/sharkdp/bat/releases/download/v0.12.1/bat_0.12.1_amd64.deb && dpkg -i /root/bat_0.12.1_amd64.deb && rm /root/bat_0.12.1_amd64.deb
    echo "======= install fzf ========"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && cd .fzf && ./install
fi

###############################################################
# => This section is for vim
###############################################################
# install vim 8.0 +
if [ $OS_RELEASE = "Linux" ];then
    add-apt-repository ppa:jonathonf/vim && apt update && apt install -y vim
elif [ $OS_RELEASE = "Darwin" ];then
   brew install vim
fi
vimpluginstall
