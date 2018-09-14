#!/bin/bash

set -e
set -x

# Update /etc/host
# required for minikube, see https://github.com/kubernetes/kubernetes/issues/39026
IFACE="enp0s3"
IPV4=$(/sbin/ifconfig $IFACE | grep -w inet | awk '{ print $2}')
sudo sed  -i "1i $IPV4 $HOSTNAME" /etc/hosts

DIR=$(cd "$(dirname "$0")"; pwd -P)
GLOBAL_GITIGNORE=".gitignore_global"
BYOBU_BASHRC="/usr/share/byobu/profiles/bashrc"

[ -n "$BYOBU_DISTRO" ] &&
{
    case "$BYOBU_DISTRO" in
        "Ubuntu" | "Debian GNU/Linux")
            if [ ! -f "${BYOBU_BASHRC}.orig" ]; then
                su -c "patch --backup ${BYOBU_BASHRC} < ${DIR}/Debian${BYOBU_BASHRC}.patch"
            fi
        ;;
        "Scientific")
            grep -q -F 'bash_aliases_git' $HOME/.bashrc || echo "source \"$DIR/$BYOBU_DISTRO/bash_aliases_git\"" >> $HOME/.bashrc
        ;;
        "S")
            # Centos7
            grep -q -F 'bash_aliases_git' $HOME/.bashrc || echo "source \"$DIR/centos/bash_aliases_git\"" >> $HOME/.bashrc
        ;;
        *)
            # Use nice colors (green / red / blue)
            echo "Distro is $BYOBU_DISTRO"
        ;;
    esac
}
# GIT

# create git config
rm -f ${HOME}/.gitconfig
echo "WARNING: git credentials are stored on disk"
git config --global user.name "Fabrice Jammes"
git config --global user.email "fabrice.jammes@in2p3.fr"

git config --global color.ui auto

git config --global alias.st "status"
git config --global alias.resetorigin "!git fetch origin && git reset --hard @{u} && git clean -f -d"
git config --global alias.logfull "log --graph --decorate"
git config --global alias.tagshowlast "describe --tags --abbrev=0"
git config --global alias.tagorigintip "!f() { git resetorigin && git tag -u fabrice.jammes -f -a -m \"Version \$1\" -s \"\$1\"; }; f"
git config --global alias.rebasemaster "!git fetch origin master && git rebase -i origin/master"

git config --global push.default simple

git config --global core.excludesfile ${HOME}/${GLOBAL_GITIGNORE}
git config --global core.editor vim

git config --global credential.helper cache --timeout=7200

# VI

mkdir -p ~/.vim/autoload ~/.vim/bundle

# install vundle
PLUGINDIR=~/.vim/bundle/Vundle.vim
rm -rf ${PLUGINDIR}
git clone https://github.com/gmarik/Vundle.vim.git ${PLUGINDIR}

# symlink config files
ln -sf ${DIR}/${GLOBAL_GITIGNORE} $HOME
ln -sf ${DIR}/.vimrc $HOME

# install Vundle plugins
vim +PluginInstall +qall
# Add to install related plugin before enabling theme
sed "s/\" colorscheme solarized/colorscheme solarized/" $HOME/.vimrc

# finish YouCompleteMe install
$HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer --gocode-complete

# zsh
rm -rf ~/.oh-my-zsh ~/.zshrc
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

FONT_DIR=/tmp/fonts
rm -rf "$FONT_DIR" 
git clone https://github.com/powerline/fonts.git --depth=1 "$FONT_DIR"
"$FONT_DIR"/install.sh

# TODO Update zshrc
sed -i 's/ZSH_THEME="robbyrussell"/export TERM="xterm-256color"\nZSH_THEME="powerlevel9k\/powerlevel9k"/g' ~/.zshrc

# Qserv
sudo -s -- chsh -s /bin/zsh qserv
cat << EOF > ~/.oh-my-zsh/custom/alias.zsh
alias cd_provision='cd ~/src/qserv/admin/tools/provision'
alias cd_kubernetes='cd ~/src/qserv/admin/tools/docker/deployment/kubernetes'
alias sshqserv='ssh -F ~/.lsst/qserv-cluster/ssh_config'
EOF
docker pull qserv/qserv:dev
mkdir -p /home/qserv/src
cd /home/qserv/src
git clone https://github.com/lsst/qserv.git
git clone https://github.com/lsst/qserv_deploy.git
# /home/qserv/src/qserv/admin/tools/docker/3_build-git-image.sh -R tickets/DM-13979
