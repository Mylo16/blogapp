require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = User.create(name: 'Antwi', photo: 'https://github.com/Mylo16/profile', bio: 'Full-stack web developer',
                        posts_counter: 0)
    @post = Post.new(author: @user, title: 'Good day!', text: 'It is a great day the Lord has blessed us with',
                     comments_counter: 0, likes_counter: 0)
  end

  it 'title should be present and 250 maximum characters' do
    @post.title = nil
    expect(@post).to_not be_valid
    @post.title = 'The Lambda'
    expect(@post).to be_valid
  end

  it 'CommentsCounter should be an integer greater than or equal to zero' do
    @post.comments_counter = 4
    expect(@post).to be_valid
  end

  it 'LikesCounter should be an integer greater than or equal to zero' do
    @post.comments_counter = 'four'
    expect(@post).to_not be_valid
  end

  it 'should update User post_counter' do
    expect do
      @post.save
      @user.reload
    end.to change(@user, :posts_counter).by(1)
  end
end
