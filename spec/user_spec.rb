require 'rails_helper'

RSpec.configure do |c|
  c.use_transactional_examples = false
  c.order = 'defined'
end

RSpec.describe 'User', type: :model do
  it 'must have a name, email and password to be valid' do
    user = User.new(name: 'user1', email: 'user1@email.com', password: '123456')
    user.save
    expect(user).to be_valid
  end
  it 'is not valid if the name is missing' do
    user = User.new(name: '', email: 'user2@email.com', password: '123456')
    user.save
    expect(user).to_not be_valid
  end
  it 'is not valid if email is missing' do
    user = User.new(name: 'user3', email: '', password: '123456')
    user.save
    expect(user).to_not be_valid
  end
  it 'is not valid if password is missing' do
    user = User.new(name: 'user4', email: 'user4@email.com', password: '')
    user.save
    expect(user).to_not be_valid
  end
  it 'is not valid if password is less than 5 characters' do
    user = User.new(name: 'me', email: 'me@email.com', password: '12345')
    user.save
    expect(user).to_not be_valid
  end
  it 'is not valid if email already exists' do
    user = User.new(name: 'user5', email: 'user1@email.com', password: '123456')
    user.save
    expect(user).to_not be_valid
  end
  describe 'assosiations' do
    it 'can have many posts' do
      user = User.reflect_on_association(:posts)
      expect(user.macro).to eql(:has_many)
    end
    it 'can have many likes' do
      user = User.reflect_on_association(:likes)
      expect(user.macro).to eql(:has_many)
    end
    it 'can have many comments' do
      user = User.reflect_on_association(:comments)
      expect(user.macro).to eql(:has_many)
    end
    it 'can have many friendships' do
      user = User.reflect_on_association(:friendships)
      expect(user.macro).to eql(:has_many)
    end
    it 'can have many friend requests' do
      user = User.reflect_on_association(:requests)
      expect(user.macro).to eql(:has_many)
    end
    it 'can have many friends' do
      user = User.reflect_on_association(:friends)
      expect(user.macro).to eql(:has_many)
    end
    it 'can have many friends' do
      user = User.reflect_on_association(:inverse_friends)
      expect(user.macro).to eql(:has_many)
    end
  end
end

RSpec.feature 'Users' do
  before(:each) do
    @user = User.create(name: 'user1', email: 'user1@email.com', password: '123456')
  end
  scenario 'when a user creates an account' do
    visit '/users/sign_up'
    fill_in 'user_name', with: '1'
    fill_in 'user_email', with: '1@email.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
  scenario 'when a user logs in' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'user1@email.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
  scenario 'when a user logs out' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'user1@email.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
    click_on 'Sign out'
    expect(current_path).to eql('/users/sign_in')
  end
  scenario 'when a sign out user tries presses the timeline link' do
    visit '/users/sign_in'
    click_on 'Timeline'
    expect(current_path).to eql('/users/sign_in')
  end
  scenario 'when a logged in user tries to access the user list' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'user1@email.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
    click_on 'All users'
    expect(current_path).to eql('/users')
  end
  scenario 'when a logged in user tries to access Timeline' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'user1@email.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
    visit '/users'
    click_on 'Timeline'
    expect(current_path).to eql('/posts')
  end
  scenario 'when a logged in user tries to access Stay in touch' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'user1@email.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
    visit '/users'
    click_on 'Stay in touch'
    expect(current_path).to eql('/')
  end
  scenario 'when a logged in user tries to access his profile' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'user1@email.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
    click_on 'user1'
    expect(current_path).to eql('/users/1')
  end
end
