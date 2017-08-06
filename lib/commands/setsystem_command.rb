class SetsystemCommand

    def initialize(bcdice, system_store)
        @bcdice = bcdice
        @hash = system_store
        @attr = /^set:\s*(.+?)$/
    end

    def attribute
        {start_with:@attr, private:false}
    end

    def process(eve)
        system = (eve.text.match(@attr))[1]
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