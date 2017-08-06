class ShowsystemCommand

    def initialize(bcdice, system_store)
        @bcdice = bcdice
        @hash = system_store
    end

    def attribute
        {content:'system'}
    end

    def process(eve)
        if(eve.server == nil)
            return
        end

        system = @hash[eve.server.id]
        _, sys_name = @bcdice.findSystem(system)
        eve.respond sys_name
    end

end