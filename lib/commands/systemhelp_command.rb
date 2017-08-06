class SystemhelpCommand

    def initialize(bcdice, system_store)
        @bcdice = bcdice
        @hash = system_store
    end

    def attribute
        {content:'!systemhelp', private:false}
    end

    def process(eve)
        system = @hash[eve.server.id]
        @bcdice.setGameByTitle(system)
        text = @bcdice.getHelpMessage
        if(text == '')
            text = '説明はありません'
        end
        eve.user.pm("```#{text}```")
    end

end