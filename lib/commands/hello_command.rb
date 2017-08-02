class HelloCommand

    attr_accessor :attribute, :process

    def initialize
        @attribute = {content:'こんにちわ'}
        
        @process = Proc.new do |eve|
            eve.respond "#{eve.user.name}さん、こんにちは"
        end
    end

end