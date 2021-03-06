#!/usr/bin/env ruby

$LOAD_PATH << File.dirname(__FILE__)+'/lib'

require 'discordrb'
require 'bcdice_wrapper'
require 'command_manager'
require 'commands/autoload.rb'

bcdice = DiscordBCDiceMaker.new.newBcDice
bcdice.after_initialize

# load Discord bot clientID and token
# first line: client_id, second line: token
# clientID and token will read from current directory
key = []
File.open(Dir.pwd + "/token.txt").each_line do |line|
    key.push(line.strip)
end

bot = Discordrb::Bot.new client_id: key[0].to_i, token: key[1]
system_store = Hash.new('None')

manager = CommandManager.new(bot)

manager.add(HelloCommand.new)
manager.add(SystemlistCommand.new(bcdice))
manager.add(SetsystemCommand.new(bcdice, system_store))
manager.add(SystemhelpCommand.new(bcdice, system_store))
manager.add(ShowsystemCommand.new(bcdice, system_store))
manager.add(DicerollCommand.new(bcdice, system_store))

manager.run
