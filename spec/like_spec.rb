require 'rails_helper'

RSpec.configure do |c|
  c.use_transactional_examples = false
  c.order = 'defined'
end

RSpec.describe 'Like', type: :model do
  describe 'assosiations' do
    it 'belongs to a post' do
      like = Like.reflect_on_association(:post)
      expect(like.macro).to eql(:belongs_to)
    end
    it 'belongs to a user' do
      like = Like.reflect_on_association(:user)
      expect(like.macro).to eql(:belongs_to)
    end
  end
end

RSpec.feature 'Likes' do
end
