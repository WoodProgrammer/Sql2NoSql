require 'observer'

class Ticker
    include Observable

    def initialize
        
    end
    def run
        loop do 
            notify_observers(Time.now)
        end

    end
end


x = Ticker.new

x.run