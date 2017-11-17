
#!/usr/bin/ruby

require 'mongo'


class MongoClient

  def initialize(database)
    Mongo::Logger.logger.level = ::Logger::FATAL
    @client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => database)
  end


  def insert_doc(col,doc)
    @client[col].insert_one doc

  end
  
  def finalize
    @client.closes
  end

end

