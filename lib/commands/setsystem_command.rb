class SetsystemCommand

    def initialize(bcdice, system_store)
        @bcdice = bcdice
        @hash = system_store
    end

    def attribute
        {start_with:"set:"}
    end

    def process(eve)
        # if server is nil(i.e. private message), return function
        if(eve.server == nil)
            return
        end

        system = (eve.text.match(/^set:\s*(.+?)$/))[1]
        system_name = '';

        if(!@bcdice.validSystem?(system))
            system = 'None'
            system_name = nil
        else
            system, system_name = @bcdice.findSystem(system)
        end

        @hash[eve.server.id] = system
        if(system_name.nil?)
            eve.respond "#{eve.user.name}:ダイスが解除されました"
        else
            eve.respond "#{eve.user.name}:ゲームが#{system_name}にセットされました"
        end

    end

end