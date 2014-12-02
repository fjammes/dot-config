#!/bin/bash

DIR=$(cd "$(dirname "$0")"; pwd -P)
GLOBAL_GITIGNORE=".gitignore_global"

[ -n "$BYOBU_DISTRO" ] || 
{
    echo "Please start byobu before running this script"
    exit 1
}

case "$BYOBU_DISTRO" in
	"Ubuntu")
		su -c "patch --backup /usr/share/byobu/profiles/bashrc < ${DIR}/Ubuntu14.04/usr/share/byobu/profiles/bashrc.patch"
	;;
	*)
		# Use nice colors (green / red / blue)
		echo "Distro is $BYOBU_DISTRO"
	;;
esac


# create git config
git config --global user.name "Fabrice Jammes"
git config --global user.email "fabrice.jammes@in2p3.fr"

git config --global color.ui auto

git config --global alias.st "status" 
git config --global alias.resetorigin "!git fetch origin && git reset --hard @{u} && git clean -f -d"
git config --global alias.logfull "log --graph --decorate"
git config --global alias.tagshowlast "describe --tags --abbrev=0"
git config --global alias.tagorigintip "!f() { git resetorigin && git tag -u fabrice.jammes -f -a -m \"Version $1\" -s \"$1\"; }; f"
git config --global alias.rebasemaster "!git fetch origin master && git rebase -i origin/master"

git config --global push.default simple

git config --global core.excludesfile ${HOME}/${GLOBAL_GITIGNORE}
git config --global core.editor vi 

# symlink config files
ln -sf ${DIR}/${GLOBAL_GITIGNORE} $HOME
ln -sf ${DIR}/.vimrc $HOME

