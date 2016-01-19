require 'rails_helper'

feature 'user signs out' do
  let(:user) do
    FactoryGirl.create(:user)
  end

  before do
    visit root_path
    click_link 'Sign In'
  end

  scenario 'sign in and then sign out successfully' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    click_link 'Sign Out'

    expect(page).to have_content("Signed out successfully.")

  end
end
