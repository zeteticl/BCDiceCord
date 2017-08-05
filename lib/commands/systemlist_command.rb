class SystemlistCommand

    def initialize(bcdice)
        @bcdice = bcdice
    end

    def attribute
        {content:"!systemlist"}
    end

    def process
        Proc.new do |eve|
            help_lines = @bcdice.validSystemlist

            # Discord message character limit is 2000 chars
            # partition text by 2000 char
            arr = []
            count = 0
            help_lines.each do |line|
                count += line.length + 1
                idx = count / 2000

                if(arr[idx].nil?) then
                    arr[idx] = line << "\n"
                else
                    arr[idx] << line << "\n"
                end
            end
            
            arr.each do |text|
                eve.user.pm("```#{text}```")
            end
        end
    end


end
