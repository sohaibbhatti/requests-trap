require 'rails_helper'

RSpec.describe RequestsController, :type => :controller do
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

      it 'returns a sucesful response' do
        post :create, trap_id: 'waffle', data: { foo: 'bar' }
        expect(response.code).to eql '201'
        expect(response.body).to eq({ok: true}.to_json)
      end
    end
  end
end
