require 'rails_helper'

feature 'user signs up' do
  context "with username and password" do
    before do
      visit root_path
      click_link 'Sign Up'
    end

    scenario 'specify valid and required information' do
      fill_in 'Username', with: 'Jon'
      fill_in 'Email', with: 'user@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'Password Confirmation', with: 'password'
      click_button 'Sign up'

      expect(page).to have_content("You're in!")
      expect(page).to have_content("Sign Out")

    end

    scenario 'required information is not supplied' do
      click_button 'Sign up'

      expect(page).to have_content("can't be blank")
      expect(page).to_not have_content("Sign Out")
    end

    scenario 'password confirmation does not match confirmation' do
      fill_in 'user_password', with: 'password'
      fill_in 'Password Confirmation', with: 'somethingdifferent'

      click_button 'Sign up'
      expect(page).to have_content("doesn't match")
      expect(page).to_not have_content("Sign Out")
    end
  end
end
