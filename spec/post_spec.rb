require 'rails_helper'

RSpec.configure do |c|
  c.use_transactional_examples = false
  c.order = 'defined'
end

RSpec.describe 'Post', type: :model do
  it 'must have content to be valid' do
    user = User.create(name: 'me', email: 'me@email.com', password: '123456')
    post = user.posts.new(content: 'content')
    post.save
    expect(post).to be_valid
  end
  it 'is not valid if the content is empty' do
    user = User.create(name: 'me', email: 'me@email.com', password: '123456')
    post = user.posts.new(content: '')
    post.save
    expect(post).to_not be_valid
  end
  describe 'assosiations' do
    it 'belongs to a user' do
      post = Post.reflect_on_association(:user)
      expect(post.macro).to eql(:belongs_to)
    end
    it 'can have many comments' do
      post = Post.reflect_on_association(:comments)
      expect(post.macro).to eql(:has_many)
    end
    it 'can have many likes' do
      post = Post.reflect_on_association(:likes)
      expect(post.macro).to eql(:has_many)
    end
  end
end

RSpec.feature 'Posts' do
  before(:each) do
    @user = User.create(name: 'user1', email: 'user1@email.com', password: '123456')
  end
  scenario 'when a logged in user tries to make a post' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'user1@email.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
    fill_in 'post_content', with: 'post'
    click_on 'Save'
    expect(current_path).to eql('/posts')
    expect(page).to have_content 'Post was successfully created.'
  end
end