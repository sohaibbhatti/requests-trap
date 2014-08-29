require 'rails_helper'

RSpec.describe Request, :type => :model do
  let(:request) { Request.new trap_name: 'fire_field', data: { kung: 'foo' } }

  it 'succesfully persists to the DB' do
    expect(request.save).to be true
  end

  it 'requires the trap to be present' do
    request.trap_name = nil
    expect { request.save }.to raise_error(ActiveRecord::StatementInvalid)
  end

  it 'requires the data to be present' do
    request.data = nil
    expect { request.save }.to raise_error(ActiveRecord::StatementInvalid)
  end


  it 'removes rails specific data from the request' do
    request.data = {
      'REQUEST_METHOD' => 'POST',
      "REMOTE_ADDR" => "0.0.0.0" ,
      "QUERY_STRING" => "waffle%5Bfoo%5D=bar",
      "action_dispatch.parameter_filter" => [:password],
      "rack.run_once" => false
    }
    request.save

    expect(request.data.keys).to include('REQUEST_METHOD', 'REMOTE_ADDR', 'QUERY_STRING')
  end

  describe '.by_trap_name' do
    it 'returns requests with the specified trap name' do
      request_one   = Request.create trap_name: 'fire_field', data: { kung: 'foo'}
      request_two   = Request.create trap_name: 'fire_and_ice', data: { kung: 'foo'}
      request_three = Request.create trap_name: 'fire_field', data: { kung: 'foo'}


      result = Request.by_trap_name 'fire_field'
      expect(result.size).to eql(2)
      expect(result.pluck(:trap_name).uniq).to eql ['fire_field']
    end

    it 'returns requests in descending order' do
      request_one   = Request.create trap_name: 'fire_field', data: { kung: 'foo'}
      request_two   = Request.create trap_name: 'fire_and_ice', data: { kung: 'foo'}
      request_three = Request.create trap_name: 'fire_field', data: { kung: 'foo'}


      result = Request.by_trap_name 'fire_field'
      expect(result[0]).to eql request_three
      expect(result[1]).to eql request_one

    end
  end
end
