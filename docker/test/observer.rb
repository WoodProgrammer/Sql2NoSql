require "observer"

class Ticker          
  include Observable

  def initialize(symbol)
    @symbol = symbol
  end

  def run
    lastPrice = nil
    loop do
      price = Price.fetch(@symbol)
      print "Current price: #{price}\n"
      if price != lastPrice
        changed                 
        lastPrice = price
        notify_observers(Time.now, price)
      end
      sleep 1
    end
  end
end

class Price          
  def Price.fetch(symbol)
    60 + rand(80)
  end
end

class Warner         
  def initialize(ticker, limit)
    @limit = limit
    ticker.add_observer(self)
  end
end

class WarnLow < Warner
  def update(time, price)       
    if price < @limit
      print "--- #{time.to_s}: Price below #@limit: #{price}\n"
    end
  end
end

ticker = Ticker.new("MSFT")
WarnHigh.new(ticker, 120)
ticker.run
