lsb_release -d

DIR=$(cd "$(dirname "$0")"; pwd -P)

GLOBAL_GITIGNORE=".gitignore_global"

ln -sf ${DIR}/${GLOBAL_GITIGNORE} $HOME
ln -sf ${DIR}/.vimrc $HOME

git config --global user.name "Fabrice Jammes"
git config --global user.email "fabrice.jammes@in2p3.fr"

git config --global color.ui auto

git config --global alias.st "status" 
git config --global alias.resetorigin "!f() { git fetch origin && git reset --hard @{u} && git clean -f -d; }; f"
git config --global alias.logfull "log --graph --decorate"
git config --global alias.rebasemaster "!git fetch origin master && git rebase -i origin/master"

git config --global push.default simple

git config --global core.excludesfile ${HOME}/${GLOBAL_GITIGNORE}
git config --global core.editor vi 
