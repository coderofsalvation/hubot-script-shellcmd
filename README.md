hubot-script-shellcmd
=====================

Easily list/Execute shellcommands from a specified folder

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

This plugin uses a bash-script as entry plugin for security reasons:

    HUBOT_SHELLCMD="bash/handler" 

