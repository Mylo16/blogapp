class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :update_post_likes

  def update_post_likes
    post.update_likes_counter
  end
end
