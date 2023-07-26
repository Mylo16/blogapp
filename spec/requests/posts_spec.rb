require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users/1/posts'
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Show the current post</h1>')
      expect(response).to render_template('posts/index')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/users/1/posts/1'
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>List of all posts</h1>')
      expect(response).to render_template('posts/show')
    end
  end
end
