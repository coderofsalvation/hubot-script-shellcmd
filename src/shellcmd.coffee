# Description:
#   List/Execute shellcommands from a specified folder.
#
# Dependencies:
#  None
#
# Configuration
#   HUBOT_SHELLCMD="bash/handler" (cp the example 'bash'-directory to your root/runtime folder)
#
# where 'handler' is a shellscript like:
#
# Commands:
#  Hubot shellcmd - list (bash)shell commands 
#  Hubot shellcmd <foo> - performs bashshell command
#
# Author:
#  Leon van Kammen / Coderofsalvation
#

module.exports = (robot) ->
  run_cmd = (cmd, args, cb ) ->
    spawn = require("child_process").spawn
    child = spawn(cmd, args)
    child.stdout.on "data", (buffer) -> cb buffer.toString()
    child.stderr.on "data", (buffer) -> cb buffer.toString()
    #child.stdout.on "end", -> cb resp
  
  robot.respond /shellcmd$/i, (msg) ->
    cmd = process.env.HUBOT_SHELLCMD;
    run_cmd cmd, [], (text) -> msg.send text

  robot.respond /shellcmd (.*)/i, (msg) ->
    msg.match[0] = msg.match[0].replace(/^[a-z0-9]+$/i);
    msg.match.shift();
    args = msg.match[0].split(" ");
    cmd = process.env.HUBOT_SHELLCMD;
    run_cmd cmd, args, (text) -> msg.send text.replace("\n","")
