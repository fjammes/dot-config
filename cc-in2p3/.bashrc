###############################################################################
#                                                                             #
#                        CENTRE DE CALCUL DE L'IN2P3                          #
#                 Copyright (c) 2000 - All rights reserved.                   #
#                                                                             #
#                             ---------------                                 #
#                                                                             #
#     Please report problems, comments and remarks to the CCIN2P3 user        #
#            support team at http://cctools.in2p3.fr/usersupport              #
#                                                                             #
#                          .basrc template file                               #
###############################################################################

#=============================================================================#
#                Write in this file your alias definitions.                   #
#=============================================================================#

# Configure the retrieve cursor functions.
# set -o emacs
# alias __A=     # cursor up
# alias __B=     # cursor down
# alias __C=     # cursor right
# alias __D=     # cursor left

# To avoid damaging files.
alias rm='rm -i'
alias cp='cp -i'

# To see more file attributes in simple view.
alias ls='ls -F'

alias vi='vim'

# git/byobu prompt
if [ -n "$(which byobu 2> /dev/null)" ]; then
    _byobu_sourced=1 . /usr/bin/byobu-launch
    . $HOME/src/dot-config/Scientific/bash_aliases_git
fi
###############################################################################
