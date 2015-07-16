hubot-script-shellcmd
=====================

Easily list/Execute shellcommands from a specified folder, and logs to rsyslog
whenever possible.

### Commands:

* Hubot shellcmd - list (bash)shell commands 
* Hubot shellcmd <foo> - performs bashshell command

### Example

    # install
    cd <yourhubotdir>
    npm install hubot-script-shellcmd

    # optional: separate your shellcmds from the npm module
    cp -R node_modules/hubot-script-shellcmd/bash .

    # run bot
    (add 'hubot-script-shellcmd' to external-scripts.json if needed)
    node_modules/.bin/hubot

In hubot:

    you> hubot shellcmd

    hubot> Available commands:
    hubot>   helloworld

    you> hubot shellcmd helloworld 
    hubot> helloworld

### Why

Sometimes its easier to trigger bashscripts or do things in bash (git deployment, server mintenance thingies, remote stuff e.g.)

###  Configuration:

Just drop / paste your bash-scripts into `hubot_dir/node_modules/hubot-script-shellcmd/src/bash/handlers/`
Done.

> In case you separated your bashscripts from the npm module (see Example Section) the directory is `bash/handlers` in hubot's working directory

# Optional: rename the 'shellcmd' directive

Some people would prefer typing `foo helloworld` instead of `shellcmd helloworld`.
In that case please introduce this environmentvariable:

    HUBOT_SHELLCMD_KEYWORD='foo'
  
    (for more env-var usage see the next section)

For example:

    $ HUBOT_SHELLCMD_KEYWORD='foo' .bin/hubot 
    hubot> hubot foo
    Available commands:
      helloworld

# Optional: specify different paths

The plugin uses a main bash-script as entry point for the your bash-scripts in `handlers/*` for security reasons.
By default it will point to `bash/handler`, for most people this will be fine.
Some people, who want to bypass this behavious can specify their own startup-script by setting an (startup) env-var:

    HUBOT_SHELLCMD="/foo/bar/myhandler" 

in short, you can run hubot like this on the commandline:

    $ HUBOT_SHELLCMD="/foo/bar/myhandler" node <hubotfile>

or just put this somewhere in your code:

    process.env.HUBOT_SHELLCMD="/foo/bar/myhandler";

or just put this in your .bashrc or shellscript before launching hubot

    export HUBOT_SHELLCMD="/foo/bar/myhandler" 

The default handler works fine, but you could define one like this:

myhandler:

    allowed="dofoo bar reset"
    for cmd in allowed; do 
      [[ "$1" == "$cmd" ]] && "$@" # execute if allowed
    done
