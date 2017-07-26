#!/usr/bin/ruby -Ku

require 'discordrb'
require 'sequel'
require_relative 'lib/bcdice_wrapper.rb'

DATABASE = __dir__+"/database.sqlite"

bcdice = DiscordBCDiceMaker.new.newBcDice

if(!FileTest.exist?(DATABASE))
    puts "no database error"
    exit 1
end

begin
    db = Sequel.sqlite(DATABASE)[:servers]
rescue => err
    puts err.message
    exit 1
end

# load Discord bot clientID and token
# first line: client_id, second line: token
key = []
File.open("./token.txt").each_line do |line|
    key.push(line)
end

bot = Discordrb::Bot.new client_id: key[0].to_i, token: key[1].gsub(/\n/, '')

# server invited event
bot.server_create do |eve|
    id = eve.server.id
    db.insert(:server_id=>id, :system=>"None")
end

# server kicked event
bot.server_delete do |eve|
    id = eve.server.id
    db.where(:server_id=>id).delete
end

# Hello, bot
bot.message(contains: "こんにちは") do |eve|
  eve.respond "#{eve.user.name}さん、こんにちは"
end

# set system event
bot.message(contains: "set:") do |eve|
    system = (/^set:( *)(.+)/.match(eve.text))[2].gsub(/\n/, '')
    unless bcdice.validSystem?(system)
        system = "None"
    end
    db.where(:server_id =>eve.server.id)
      .update(:server_id=>eve.server.id, :system=>system)

    if(system == "None")
        eve.respond "#{eve.user.name}:ダイスが解除されました"
    else
        eve.respond "#{eve.user.name}:ゲームが#{system}にセットされました"
    end
end

# show now system event
bot.message(contains: "system") do |eve|
    nowSystem = db.where(:server_id =>eve.server.id).select(:system).get
    eve.respond "nowSystem"
end

# dice roll event
bot.message(containing: not!("set:")) do |eve|
    bcdice.setNick(eve.user.name)
    system = db.where(:server_id => eve.server.id).get(:system)
    bcdice.setGameByTitle(system)
    bcdice.setMessage(eve.text)
    message, _ = bcdice.dice_command
    if (message != "" || message != "1")
        eve.respond message
    end
end

bot.run
