require 'rails_helper'

RSpec.describe RequestsController, :type => :controller do
  describe 'index' do
    it "returns http success" do
      get :index, trap_id: 'waffle'
      expect(response).to be_success
    end
  end

  describe 'create' do
    it 'handles multipe HTTP request VERBS ' do
      post :create, trap_id: 'waffle'
      expect(response).to be_success

      get :create, trap_id: 'waffle'
      expect(response).to be_success

      patch :create, trap_id: 'waffle'
      expect(response).to be_success

      delete :create, trap_id: 'waffle'
      expect(response).to be_success
    end

    context 'success' do
      it 'saves relevant Request data' do
        request.headers['X-AUTH-TOKEN'] = 'auth-token'
        request.headers['X-EMAIL'] = 'email'

        post :create, trap_id: 'waffle', data: { foo: 'bar' }
        request_data = Request.first.data
        expect(request_data['HTTP_X_EMAIL']).to eql 'email'
        expect(request_data['HTTP_X_AUTH_TOKEN']).to eql 'auth-token'
      end

      it 'returns a success response' do
        post :create, trap_id: 'waffle', data: { foo: 'bar' }
        expect(response.code).to eql '201'
        expect(response.body).to eq({ok: true}.to_json)
      end
    end

    context 'failure' do
      it 'notifies in the event of being unable to save' do
        Request.stub_chain(:new, :save).and_return false

        post :create, trap_id: 'waffle', data: { foo: 'bar' }
        expect(response.code).to eql '400'
        expect(response.body).to eq({ok: false}.to_json)
      end

      it 'notifies in the event of a crash' do
        trap_request = Request.new
        allow(Request).to receive(:new) { trap_request }

        post :create, trap_id: 'waffle', data: { foo: 'bar' }
        expect(response.code).to eql '500'
        expect(response.body).to eq({ok: false}.to_json)
      end
    end
  end
end
