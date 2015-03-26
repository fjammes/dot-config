# see enabled product with:
# eups list -s qserv_testdata -v

hooks.config.Eups.colorize = True
hooks.config.Eups.userTags += ["git", "qserv"]

def cmdHook(Eups, cmd, opts, args):
   if Eups and cmd == "setup":
       if not opts.tag:
           opts.tag = ["git", "qserv"]

           if opts.verbose >= 0:
               import utils
               msg = "Using default tags: {0} to setup {1}" \
                   .format(", ".join(opts.tag), ", ".join(args))
               print >> utils.stdinfo, msg

eups.commandCallbacks.add(cmdHook)
