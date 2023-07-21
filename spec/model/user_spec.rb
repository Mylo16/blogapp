require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations for User model' do
    subject { User.new(name: 'Antwi Eric', photo: 'https://github.com/Mylo16/profile', bio: 'Full-stack web developer', posts_counter: 0) }

    before { subject.save }

    it 'name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'PostsCounter should be greater than or equal to zero' do
      subject.posts_counter = -3
      expect(subject).to_not be_valid
    end

    it 'Should return less than 3 posts' do
      number_of_posts = subject.recent_posts.length
      expect(number_of_posts).to be < 3
    end
  end
end
