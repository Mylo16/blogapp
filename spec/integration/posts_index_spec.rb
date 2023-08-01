require 'rails_helper'

RSpec.describe 'Render Post index page', type: :system do
  before do
    driven_by(:rack_test)

    @user = User.create(name: 'Kusi', photo: 'user.jpg', bio: 'Teacher at Anwomaso')
    @post1 = @user.posts.create(title: 'Post 1', text: 'My first post')
    @post2 = @user.posts.create(title: 'Post 2', text: 'My second post')
    @post3 = @user.posts.create(title: 'Post 3', text: 'My third post')
    @comment1 = @post1.comments.create(text: 'Hi friend!', author: @user)
    @comment2 = @post2.comments.create(text: 'Nice', author: @user)
    @comment3 = @post3.comments.create(text: 'Awesome', author: @user)
    @like1 = @post1.likes.create(author: @user)
    @like2 = @post2.likes.create(author: @user)
    @like3 = @post3.likes.create(author: @user)

    visit user_posts_path(user_id: @user.id)
  end

  it "shows user's name" do
    expect(page).to have_content(@user.name)
  end

  it 'shows the number of posts' do
    expect(page).to have_content('Number of posts: 3')
  end

  it 'redirects to clicked post page' do
    post = Post.find_by(title: 'Post 1')
    click_link post.title
    expect(current_path).to eq(user_post_path(user_id: @user.id, id: post.id))
  end

  it "shows the user's profile picture" do
    expect(page).to have_selector("img[src$='#{@user.photo}']")
  end

  it "shows title and text of user's post" do
    @user.posts.each do |post|
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
    end
  end

  it "shows posts' comments" do
    expect(page).to have_content('Hi friend!')
  end

  it 'shows number of likes for a post' do
    expect(page).to have_content('Likes: 1')
  end

  it 'Shows number of comments on a post' do
    expect(page).to have_content('Comments: 1')
  end
end
