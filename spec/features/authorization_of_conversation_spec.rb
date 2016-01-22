require 'rails_helper'

feature "user visits a conversation show page" do
  context "unauthorized user" do
    let(:bad_user) { FactoryGirl.create(:user) }
    let!(:conversation) { FactoryGirl.create(:conversation) }

    before do
      visit root_path
      click_link "Sign In"
      fill_in 'Email', with: bad_user.email
      fill_in 'Password', with: bad_user.password
      click_button 'Log in'
    end

    scenario "unauthorized user tries to go to a conversation show page" do
      visit conversation_path(conversation)
      expect(page).to_not have_content("Chatroom")
      expect(page).to_not have_css('form.new_message')
      expect(page).to have_content('You are not authorized to enter this chat')
    end
  end

  context "authorized user" do
    let!(:conversation) { FactoryGirl.create(:conversation) }

    before do
      visit root_path
      click_link "Sign In"
      fill_in 'Email', with: conversation.sender.email
      fill_in 'Password', with: conversation.sender.password
      click_button 'Log in'
    end

    scenario "authorized user visits conversation show page" do
      visit conversation_path(conversation)

      expect(page).to have_content("Chatroom")
      expect(page).to have_css('form.new_message')
    end
  end
end
