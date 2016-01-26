require 'rails_helper'

feature "visitor visits a conversation show page" do
  context "signed in user clicking on the Start Conversation button" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:user2) { FactoryGirl.create(:user) }

    before do
      visit root_path
      click_link "Sign In"
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      click_button("Chat")
      fill_in "Body", with: "Hey man!"
      click_button "Send"
    end

    scenario "other user sees new message in show page" do
      visit user_path(user2)
      expect(page).to_not have_content("new message(s)")

      click_link "Sign Out"
      visit root_path
      click_link "Sign In"
      fill_in 'Email', with: user2.email
      fill_in 'Password', with: user2.password
      click_button 'Log in'
      visit user_path(user2)
      expect(page).to have_content("1 new message(s)")

      # click_link "wants to talk!"
      # fill_in "Body", with: "Yo"
      #
      # click_link "Sign Out"
      # visit root_path
      # click_link "Sign In"
      # fill_in 'Email', with: user2.email
      # fill_in 'Password', with: user2.password
      # click_button 'Log in'
      # visit user_path(user2)
      #
      # expect(page).to_not have_content("1 new message(s)")

    end
  end
end
