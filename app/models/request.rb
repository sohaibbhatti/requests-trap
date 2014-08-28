class Request < ActiveRecord::Base
  before_create :siphon_rails_data

  private

  def siphon_rails_data
    return unless data.is_a? Hash
    data.select! { |k,v| !is_rails_related_data? k }
  end

  # Rails adds additional keys to the request.
  def is_rails_related_data?(key)
    key.starts_with? 'action_controller.', 'action_dispatch.', 'rack.'
  end
end
