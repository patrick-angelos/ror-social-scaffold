require 'rails_helper'
require_relative 'factories'
require_relative 'support/factory_bot'

RSpec.configure do |c|
  c.use_transactional_examples = false
  c.order = 'defined'
end

RSpec.describe 'Like', type: :model do
  it 'creates valid likes' do
    expect(create(:like)).to be_valid
  end
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
