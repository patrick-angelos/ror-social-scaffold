require 'rails_helper'

RSpec.configure do |c|
  c.use_transactional_examples = false
  c.order = 'defined'
end

RSpec.describe 'Friendship', type: :model do
  describe 'assosiations' do
    it 'belongs to a friend' do
      friendship = Friendship.reflect_on_association(:friend)
      expect(friendship.macro).to eql(:belongs_to)
    end
    it 'belongs to an inverse_friend' do
      friendship = Friendship.reflect_on_association(:inverse_friend)
      expect(friendship.macro).to eql(:belongs_to)
    end
  end
end
# rubocop:disable Metrics/BlockLength
RSpec.feature 'Friendships' do
  before(:each) do
    @user = User.create(name: 'user1', email: 'user1@email.com', password: '123456')
  end
  before(:each) do
    @user = User.create(name: 'user2', email: 'user2@email.com', password: '123456')
  end
  scenario 'when a loged in user sents a friend request' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'user1@email.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
    click_on 'All users'
    click_on 'Invite'
    expect(page).to have_content 'Invitation Sent'
  end
  scenario 'when a loged in user rejects a friend request' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'user2@email.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
    click_on 'user2'
    click_on 'Reject'
    expect(page).to have_content 'Invitation Rejected'
  end
  scenario 'when a loged in user accepts a friend request' do
    visit '/users/sign_in'
    fill_in 'user_email', with: 'user1@email.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
    click_on 'All users'
    click_on 'Invite'
    click_on 'Sign out'
    fill_in 'user_email', with: 'user2@email.com'
    fill_in 'user_password', with: '123456'
    click_on 'Log in'
    click_on 'user2'
    click_on 'Accept'
    expect(page).to have_content 'Invitation Accepted'
  end
end
# rubocop:enable Metrics/BlockLength
