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
fs = require("fs")

process.env.HUBOT_SHELLCMD = "bash/handler" if not process.env.HUBOT_SHELLCMD
if not fs.existsSync(process.env.HUBOT_SHELLCMD)
  console.log process.env.HUBOT_SHELLCMD+" not found in hubot working dir..defaulting to example handler at "+__dirname+"/../bash/handler"
  process.env.HUBOT_SHELLCMD = __dirname+"/../bash/handler" 
process.env.HUBOT_SHELLCMD_KEYWORD = "shellcmd" if not process.env.HUBOT_SHELLCMD_KEYWORD

module.exports = (robot) ->
  run_cmd = (cmd, args, envs, cb ) ->
    console.log "spawn!"
    spawn = require("child_process").spawn
    opts = 
        env: envs        
    child = spawn(cmd, args, opts)
    child.stdout.on "data", (buffer) -> cb buffer.toString()
    child.stderr.on "data", (buffer) -> cb buffer.toString()
    #child.stdout.on "end", -> cb resp
  
  robot.respond "/"+process.env.HUBOT_SHELLCMD_KEYWORD+"$/i", (msg) ->
    cmd = process.env.HUBOT_SHELLCMD;
    envs = process.env;
    envs["HUBOT_USER_" + key.toUpperCase()] = value for key, value of msg.envelope.user
    run_cmd cmd, [], envs, (text) -> msg.send text

  robot.respond "/"+process.env.HUBOT_SHELLCMD_KEYWORD+" (.*)/i", (msg) ->
    msg.match[0] = msg.match[0].replace(/^[a-z0-9]+$/i);
    msg.match.shift();
    args = msg.match[0].split(" ");
    cmd = process.env.HUBOT_SHELLCMD;
    envs = process.env;
    envs["HUBOT_USER_" + key.toUpperCase()] = value for key, value of msg.envelope.user
    run_cmd cmd, args, envs, (text) -> msg.send text.replace("\n","")

