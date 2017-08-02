# command manager

class CommandManager

    def initialize(bot)
        @bot = bot
    end

    def add(command)
        @bot.message(command.attribute) do |eve|
            command.process.call(eve)
        end
    end

    def run
        @bot.run
    end

end