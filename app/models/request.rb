class Request < ActiveRecord::Base
  before_create :siphon_rails_data
  after_create :publish_to_stream

  scope :by_trap_name, ->(trap_name) {where(trap_name: trap_name).order('created_at DESC') }

  private

  def publish_to_stream
    StreamHandler.new(self.class.connection, trap_name).publish!(id)
  end

  def siphon_rails_data
    return unless data.is_a? Hash
    data.select! { |k,v| !is_rails_related_data? k }
  end

  # Rails adds additional keys to the request.
  def is_rails_related_data?(key)
    key.starts_with? 'action_controller.', 'action_dispatch.', 'rack.'
  end
end
