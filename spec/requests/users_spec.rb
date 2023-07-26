require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users'
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Current User</h1>')
      expect(response).to render_template('users/index')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/users/show'
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Here are list of Users:</h1>')
      expect(response).to render_template('users/show')
    end
  end
end
