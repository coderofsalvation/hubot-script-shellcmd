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
    cp -R node_modules/hubot-script-shellcmd/bash .

    # add shellcommands
    echo -e "echo helloworld" > bash/handlers/helloworld
    chmod 755 bash/handlers/helloworld

    # run bot
    (add 'hubot-script-shellcmd' to external-scripts.json)
    bin/hubot

In hubot:

    you> hubot shellcmd

    hubot> Available commands:
    hubot>   helloworld

    you> hubot shellcmd helloworld 
    hubot> helloworld

### Why

Sometimes its easier to trigger bashscripts or do things in bash (git deployment, server mintenance thingies, remote stuff e.g.)

###  Configuration:

This plugin uses a bash-script as entry point for the bash-commands for security reasons.
By default it will point to the shipped bash-script, but can be changed by setting an (startup) env-var:

    HUBOT_SHELLCMD="/foo/bar/myhandler" 

in short, you can run hubot like this on the commandline:

    $ HUBOT_SHELLCMD="/foo/bar/myhandler" node <hubotfile>

or just put this somewhere in your code:

    process.env.HUBOT_SHELLCMD="/foo/bar/myhandler";

or just put this in your .bashrc or shellscript before launching hubot

    export HUBOT_SHELLCMD="/foo/bar/myhandler" 
