require 'rails_helper'

feature "user chats with other user" do
  context "user signs in and goes to conversation" do
    let(:conversation) { FactoryGirl.create(:conversation)}

    before do
      visit root_path
      click_link "Sign In"
      fill_in 'Email', with: conversation.sender.email
      fill_in 'Password', with: conversation.sender.password
      click_button 'Log in'
      visit conversation_path(conversation)
    end

    scenario "sender rates recipient" do
      expect(page).to have_content(conversation.recipient.username)
      choose "rating_score_10"
      click_button "Rate"
      visit user_path(conversation.recipient)
      expect(page).to have_content("Points Given:0")
      expect(page).to have_content("Avg Points Given:0")
      expect(page).to have_content("Points Given:0")
      expect(page).to have_content("Perfect Scores:1")
      expect(page).to have_content("0 message(s)")
    end
  end

  # context "authorized user" do
  #   let!(:conversation) { FactoryGirl.create(:conversation) }
  #
  #   before do
  #     visit root_path
  #     click_link "Sign In"
  #     fill_in 'Email', with: conversation.sender.email
  #     fill_in 'Password', with: conversation.sender.password
  #     click_button 'Log in'
  #   end
  #
  #   scenario "authorized user visits conversation show page" do
  #     visit conversation_path(conversation)
  #
  #     expect(page).to have_content("Chatroom")
  #     expect(page).to have_css('form.new_message')
  #   end
  # end
end
