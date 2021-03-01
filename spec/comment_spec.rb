require 'rails_helper'
require_relative 'factories'
require_relative 'support/factory_bot'

RSpec.configure do |c|
  c.use_transactional_examples = false
  c.order = 'defined'
end

RSpec.describe 'Comment', type: :model do
  it 'creates valid comments' do
    expect(create(:comment)).to be_valid
  end
  it 'must have content to be valid' do
    user = User.create(name: 'me', email: 'me@email.com', password: '123456')
    post = user.posts.new(content: 'content')
    post.save
    comment = post.comments.new(content: 'comment')
    comment.user_id = user.id
    comment.save
    expect(comment).to be_valid
  end
  it 'is not valid when the content is empty' do
    user = User.create(name: 'me', email: 'me@email.com', password: '123456')
    post = user.posts.new(content: 'content')
    post.save
    comment = post.comments.new(content: '')
    comment.user_id = user.id
    comment.save
    expect(comment).to_not be_valid
  end
  describe 'assosiations' do
    it 'belongs to a post' do
      comment = Comment.reflect_on_association(:post)
      expect(comment.macro).to eql(:belongs_to)
    end
    it 'belongs to a user' do
      comment = Comment.reflect_on_association(:user)
      expect(comment.macro).to eql(:belongs_to)
    end
  end
end

RSpec.feature 'Comments' do
  before(:each) do
    @user = User.create(name: 'user1', email: 'user1@email.com', password: '123456')
  end
  scenario 'when a logged in user tries to comment on a post' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'user1@email.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
    fill_in 'post_content', with: 'post'
    click_on 'Save'
    fill_in 'comment_content', with: 'this is a comment'
    click_on 'Comment'
    expect(page).to have_content 'this is a comment'
  end
end
