require 'rails_helper'

feature 'user signs in' do
  let(:user) { FactoryGirl.create(:user) }

  before do
    visit root_path
    click_link "Sign In"
  end

  scenario 'an existing user speciifies a valid email and password' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Welcome Back!')
    expect(page).to have_content('Sign Out')

  end

  scenario 'a nonexistant email and password is supplied' do
    fill_in 'Email', with: 'nobody@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'

    expect(page).to have_content('Invalid email or password.')
    expect(page).to_not have_content('Welcome Back!')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'an existing email with the wrong password is denied access' do
    fill_in 'user_email', with: user.email
    fill_in 'Password', with: 'incorrect'
    click_button 'Log in'

    expect(page).to have_content('Invalid email or password.')
    expect(page).to_not have_content('Welcome Back!')
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'an already authenticated user cannot re-sign in' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    expect(page).to have_content('Sign Out')
    expect(page).to_not have_content('Sign In')

    visit new_user_session_path
    expect(page).to have_content('You are already signed in.')
  end

end
