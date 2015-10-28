#!/bin/bash

set -e
set -x

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
        *)
            # Use nice colors (green / red / blue)
            echo "Distro is $BYOBU_DISTRO"
        ;;
    esac
}
# GIT

# create git config
rm -f ${HOME}/.gitconfig
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

# VI

mkdir -p ~/.vim/autoload ~/.vim/bundle

# install vundle 
PLUGINDIR=~/.vim/bundle/Vundle.vim
rm -rf ${PLUGINDIR}
git clone https://github.com/gmarik/Vundle.vim.git ${PLUGINDIR}

# symlink config files
ln -sf ${DIR}/${GLOBAL_GITIGNORE} $HOME
ln -sf ${DIR}/vimrc $HOME/.vimrc

# install Vundle plugins
vim +PluginInstall +qall

# finish YouCompleteMe install
$HOME/.vim/bundle/YouCompleteMe/install.py --clang-completer --gocode-complete

# eups setup using user:git tag
mkdir -p $HOME/.eups
ln -sf ${DIR}/dot-eups/startup.py $HOME/.eups
eups declare -t git -r $HOME/src/qserv/
eups declare -t git -r $HOME/src/qserv_testdata/
