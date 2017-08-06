#!/usr/bin/env ruby -Ku
#--*-coding:utf-8-*--

$LOAD_PATH << __dir__+"/bcdice/src/"
require 'cgi'
require_relative 'bcdice/src/bcdiceCore.rb'
require_relative 'bcdice/src/configBcDice.rb'

class DiscordBCDiceMaker < BCDiceMaker
    def newBcDice
        bcdice = DiscordBCDice.new(self, @cardTrader, @diceBot, @counterInfos, @tableFileData)
        return bcdice
    end
end

class DiscordBCDice < BCDice
    attr_reader :systemlist

    def after_initialize
      @systemlist = {}
      $allGameTypes.each do |sys|
        sys = replace_systemName(sys)
        require "diceBot/#{sys}.rb"
        system_name = Module.const_get(sys).new.gameName
        @systemlist[sys] = system_name
      end
    end

    def setNick(nick)
        @nick_e = nick
    end

    def validSystem?(system)
        @systemlist.has_key?(system) || @systemlist.has_value?(system)
    end

    def validSystemlist
      @systemlist.map do |system_name, system|
        "#{system_name}: #{system}"
      end
    end

    def findSystem(name)
      if(name == 'None')
        return 'None', 'デフォルト(指定なし)'
      end
      if(!self.validSystem?(name))
        raise 'invalid argument'
      end

      sys = ''
      sys_name = ''
      @systemlist.each do |key, value|
        if(key == name || value == name)
          sys = key
          sys_name = value
          break
        end
      end
      return sys, sys_name
    end

    def getHelpMessage
      @diceBot.getHelpMessage
    end

    private
    def replace_systemName(system_name)
      system_name.gsub!(/[_|!]/, "")
      system_name.gsub!(/[:|.]/, "_")
      system_name.gsub!(/&/, "And")
      case system_name
      when "GURPS"
        system_name = "Gurps"
      when "NJSLYRBATTLE"
        system_name = "NjslyrBattle"
      when "SMTKakuseihen"
        system_name = "ShinMegamiTenseiKakuseihen"
      when "TORG"
        system_name = "Torg"
      when "TORG1_5"
        system_name = "Torg1_5"
      end
      system_name
    end
end
