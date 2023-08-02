require 'rails_helper'

RSpec.describe 'Users Show', type: :system do
  before do
    driven_by(:rack_test)

    @user = User.create(name: 'John', photo: 'user1.jpg', bio: 'A teacher from Spain')
    @user.update(posts_counter: 5)

    Post.create(title: 'First Post', text: 'First Post Text', author: @user)
    Post.create(title: 'Second Post', text: 'Second Post Text', author: @user)
    Post.create(title: 'Third Post', text: 'Third Post Text', author: @user)
    Post.create(title: 'Fourth Post', text: 'Fourth Post Text', author: @user)
    Post.create(title: 'Fifth Post', text: 'Fifth Post Text', author: @user)

    visit user_path(@user)
  end

  scenario "shows the user's profile picture" do
    expect(page).to have_selector("img[src$='#{@user.photo}']")
  end

  scenario "shows the user's name" do
    expect(page).to have_content(@user.name)
  end

  scenario 'shows the number of posts' do
    expect(page).to have_content("Number of posts: #{@user.posts_counter}")
  end

  scenario 'shows the user bio' do
    expect(page).to have_content(@user.bio)
  end

  scenario "shows the user's three most recent posts" do
    recent_posts = @user.recent_posts

    recent_posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end

  scenario 'when click on a post, it redirects to the post page' do
    post = Post.find_by(title: 'Third Post')
    click_link post.title

    expect(current_path).to eq(user_post_path(user_id: @user.id, id: post.id))
  end

  scenario 'displays a button to view all posts' do
    expect(page).to have_link('See all posts')
  end
end
