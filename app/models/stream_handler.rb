# Handles publishing and listening of models
class StreamHandler
  attr_accessor :connection, :channel_name

  def initialize(db_connection, channel_name)
    @connection   = db_connection
    @channel_name = channel_name
  end

  def listen!
    @connection.execute "Listen #{@channel_name}"

    loop do
      @connection.raw_connection.wait_for_notify(0.5) do |event, pid, message|
        yield message
      end
    end

  ensure
    @connection.execute "UNLISTEN #{@channel_name}"
  end

  def publish!(message)
    @connection.execute "NOTIFY #{@channel_name}, '#{message}';"
  end
end
