# see enabled product with:
# eups list -s qserv_testdata -v

hooks.config.Eups.colorize = True
hooks.config.Eups.userTags += ["git"]

def cmdHook(Eups, cmd, opts, args):
   if Eups and cmd == "setup":
       if not opts.tag:
           opts.tag = ["git"]

           if opts.verbose >= 0:
               import utils
               print >> utils.stdinfo, "Adding default tags: %s" % (", ".join(opts.tag))

eups.commandCallbacks.add(cmdHook)
