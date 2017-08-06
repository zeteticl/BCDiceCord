class DicerollCommand

    def initialize(bcdice, system_store)
        @bcdice = bcdice
        @hash = system_store
    end

    def attribute
        {start_with: not!('!')}
    end

    def process(eve)
        if(eve.server.nil?)
            return
        end

        system = @hash[eve.server.id]

        @bcdice.setGameByTitle(system)
        @bcdice.setNick(eve.user.name)
        @bcdice.setMessage(eve.text)

        message, _ = @bcdice.dice_command

        if(message != '' && message != '1')
            eve.respond message
        end
    end

end