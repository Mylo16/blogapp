class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_create :update_post_comments

  def update_post_comments
    post.update_comments_counter
  end
end
