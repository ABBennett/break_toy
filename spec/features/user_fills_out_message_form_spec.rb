require 'rails_helper'

feature "visitor visits a conversation show page" do
  context "clicking on the Start Conversation button" do
    let!(:conversation) { FactoryGirl.create(:conversation) }

    before do
      visit root_path
      click_link "Sign In"
      fill_in 'Email', with: conversation.sender.email
      fill_in 'Password', with: conversation.sender.password
      click_button 'Log in'
      visit conversation_path(conversation)
    end

    scenario "user submits form for new message" do
      fill_in "Body", with: "Hey there!"
      click_button "Send"
      expect(page).to have_content("Hey there!")
    end
  end
end
