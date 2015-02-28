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
#                          .profile template file                             #
###############################################################################

#=============================================================================#
# This file is called at the begining of your Korn shell session. Please      #
# modify only the USER SESSION to customize your shell environment.           #
#=============================================================================#

#=============================================================================#
#                              SYSTEM SECTION                                 #
#=============================================================================#
# This section contains system profile calls. They are mandatory to set the   #
# environment needed for CCIN2P3 tools such as the Batch Queueing System      #
# (BQS) and data access services. DO NOT DISABLE OR MODIFY THIS SECTION.      #
#=============================================================================#

 if [ -r /afs/in2p3.fr/common/uss/system_profile ];then
    . /afs/in2p3.fr/common/uss/system_profile
 fi

#=============================================================================#
#                               USER SECTION                                  #
#=============================================================================#
# Modify this section to customize your shell environment. If you have        #
# ENVIRONMENT specific settings (batch/interactive), put your definitions in  # 
# the proper section as described below.                                      #
#=============================================================================#

#=============================================================================#
#                              GLOBAL SETTINGS                                #
#=============================================================================#

# Set up the search path variable.
 PATH=$PATH:.
 export PATH

# Set up the environment file (edit this file to add aliases and more...). 
 ENV=$HOME/.bashrc
 export ENV

#=============================================================================#
#                        ENVIRONMENT DEPENDENT SETTINGS                       #
#=============================================================================#

case $ENVIRONMENT in
   BATCH)		# Settings only defined in a batch session.

	# Put here your commands to be run only in a batch session.

	;;

   INTERACTIVE)		# Interactive/Login settings only.

	# Put here your commands to be run only in a login session. 

	# Set up the prompt pattern.
	PS1='${PWD}(${?})>'
	export PS1

        if [ -e $ENV ]; then
            . $ENV
        fi

	# LPD_SERVER and PRINTER are to be used with the "slpr" command to
	# send print jobs on a remote print server. Uncomment the 4 next 
	# lines and set proper values.
	#LPD_SERVER=myprinterhost
	#export LPD_SERVER
	#PRINTER=myprinter
	#export PRINTER

	# If you want to modify system default settings for your interactive 
	# sessions, this is a good place to do it.
	#PAGER=more
	#MAIL=somewhere
	EDITOR=vim
	VISUAL=vim

	;;
esac

###############################################################################
# EOF
