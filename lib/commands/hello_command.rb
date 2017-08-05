class HelloCommand

    def attribute
        {content:'こんにちわ'}
    end

    def process
        Proc.new do |eve|
            eve.respond "#{eve.user.name}さん、こんにちわ"
        end
    end

end