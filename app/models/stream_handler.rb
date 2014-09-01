# Handles publishing and listening of models
#
# Currently supports ActiveRecord based connections. Connections must
# have `execute` duck typed. For non ActiveRecord adapters, changes
# to `wait_for_notify` may be required
class StreamHandler
  attr_accessor :connection, :channel_name

  # connection - DB connection to PostgreSQL DB.
  # channel_name - DB channel name to listen or publish to
  def initialize(db_connection, channel_name)
    @connection   = db_connection
    @channel_name = channel_name
  end

  def listen!
    @connection.execute "Listen #{@channel_name}"

    loop do
      wait_for_notify do |event, pid, message|
        yield message
      end
    end

  ensure
    @connection.execute "UNLISTEN #{@channel_name}"
  end

  def publish!(message)
    @connection.execute "NOTIFY #{@channel_name}, '#{message}';"
  end

  private

  def wait_for_notify(timeout = 0.5)
    @connection.raw_connection.wait_for_notify(timeout)
  end
end
