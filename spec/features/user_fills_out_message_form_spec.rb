require 'rails_helper'

feature "visitor visits a conversation show page" do
  context "clicking on the Start Conversation button" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:user2) { FactoryGirl.create(:user) }

    before do
      visit root_path
      click_link "Sign In"
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      click_button 'Start Conversation'
    end

    scenario "user submits form for new message" do
      fill_in "Body", with: "Hey there!"
      click_button "Send"
      expect(page).to have_content("Hey there!")
    end
  end
end
