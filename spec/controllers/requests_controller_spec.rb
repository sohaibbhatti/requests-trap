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
  end
end
