require 'rails_helper'

feature "visitor sees a list of other users" do
  context "visiting the home page" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:user1) { FactoryGirl.create(:user) }
    let!(:user2) { FactoryGirl.create(:user) }

    before do
      visit root_path
      click_link "Sign In"
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end

    scenario "sees a list of other users" do
      save_and_open_page
      expect(page).to have_link user1.username
      expect(page).to have_content user2.username
      expect(page).to_not have_content user.username

    end
  end
end
