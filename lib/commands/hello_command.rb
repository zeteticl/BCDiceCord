class HelloCommand

    def attribute
        {content:'こんにちわ'}
    end

    def process(eve)
        eve.respond "#{eve.user.name}さん、こんにちわ"
    end

end