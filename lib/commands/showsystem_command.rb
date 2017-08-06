class ShowsystemCommand

    def initialize(bcdice, system_store)
        @bcdice = bcdice
        @hash = system_store
    end

    def attribute
        {content:'system', private:false}
    end

    def process(eve)
        system = @hash[eve.server.id]
        _, sys_name = @bcdice.findSystem(system)
        eve.respond sys_name
    end

end