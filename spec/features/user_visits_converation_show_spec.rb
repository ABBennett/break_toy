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
      visit users_path
    end

    scenario "signed in user clicks 'Start Conversation'" do
      click_button("Talk")
      expect(page).to have_content("Talk")
      expect(page).to have_css('form.new_message')
    end
  end

  context "not signed in user" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:user2) { FactoryGirl.create(:user) }

    scenario "not signed in user clicks 'Start Conversation'" do
      visit users_path
      first(:button, "Talk").click

      expect(page).to have_content("You must sign in to start a conversation")
      expect(page).to_not have_css('form.new_message')
    end
  end
end
