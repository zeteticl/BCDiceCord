class DicerollCommand

    def initialize(bcdice, system_store)
        @bcdice = bcdice
        @hash = system_store
    end

    def attribute
        {start_with: not!('!'), private:false}
    end

    def process(eve)
        system = @hash[eve.server.id]

        @bcdice.setGameByTitle(system)
        @bcdice.setNick(eve.user.name)
        @bcdice.setMessage(eve.text)

        message, is_secret = @bcdice.dice_command

        if(message != '' && message != '1')
            message = "`"+message+"`"
            is_secret ? eve.user.pm(message) : eve.respond(message)
        end
    end

end