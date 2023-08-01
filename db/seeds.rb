# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
second_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')

first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')
second_post = Post.create(author: first_user, title: 'Second', text: 'This is my second post')
third_post = Post.create(author: second_user, title: 'Third', text: 'This is my third post')
fourth_post = Post.create(author: second_user, title: 'Fourth', text: 'This is my fourth post')


# Create comments
Comment.create(post: first_post, author: second_user, text: 'Hi Naan!')
Comment.create(post: first_post, author: second_user, text: 'Hi Leul!')
Comment.create(post: second_post, author: second_user, text: 'Hi Melaku!')
Comment.create(post: second_post, author: first_user, text: 'Hi Samri!')
Comment.create(post: third_post, author: first_user, text: 'Hi Yohannes!')
Comment.create(post: fourth_post, author: first_user, text: 'Hi Yordi!')

# Find, update, and delete entities
user = User.find_by(name: 'Tom')
puts "User: #{user.name}"
user.update(name: 'Tom Smith')
updated_user = User.find_by(name: 'Tom Smith')
puts "Updated User: #{updated_user.name}"

post = updated_user.posts.find_by(title: 'Hello')
puts "Post Title: #{post.title}" if post
post.update(title: 'Greetings', text: 'This is my updated post') if post
updated_post = updated_user.posts.find_by(title: 'Greetings')
puts "Updated Post Title: #{updated_post.title}" if updated_post

comment = updated_post.comments.find_by(text: 'Hi Tom!') if updated_post
puts "Comment Text: #{comment.text}" if comment
comment.destroy if comment
puts "Comment Count after deletion: #{updated_post.comments.count}" if updated_post

# Call the methods
recent_posts = user.recent_posts
puts "Recent Posts for User: #{user.name}"
recent_posts.each do |post|
  puts "Title: #{post.title}, Text: #{post.text}"
end

updated_user.update_posts_counter
puts "Posts Counter for User: #{updated_user.name} - #{updated_user.posts_counter}"

recent_comments = updated_post.recent_comments
puts "Recent Comments for Post: #{updated_post.title}"
recent_comments.each do |comment|
  puts "Text: #{comment.text}"
end

updated_post.update_comments_counter
puts "Comments Counter for Post: #{updated_post.title} - #{updated_post.comments_counter}"

updated_post.update_likes_counter
puts "Likes Counter for Post: #{updated_post.title} - #{updated_post.likes_counter}"
