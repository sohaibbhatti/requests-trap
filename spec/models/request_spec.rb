require 'rails_helper'

RSpec.describe Request, :type => :model do
  let(:request) { Request.new trap_name: 'fire_field', data: { kung: 'foo' } }

  it 'succesfully persists to the DB' do
    expect(request.save).to be true
  end

  it 'requires the trap to be present' do
    request.trap_name = nil
    expect {  request.save }.to raise_error(ActiveRecord::StatementInvalid)
  end

  it 'requires the data to be present' do
    request.data = nil
    expect {  request.save }.to raise_error(ActiveRecord::StatementInvalid)
  end
end
