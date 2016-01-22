# require 'rails_helper'
#
# feature "Rating" do
#   context "authorized user" do
#     let!(:conversation) { FactoryGirl.create(:conversation) }
#
#     before do
#       visit root_path
#       find('sign-in').trigger('click')
#       fill_in 'Email', with: conversation.sender.email
#       fill_in 'Password', with: conversation.sender.password
#       click_button 'Log in'
#     end
#
#     scenario "user rates other user", js: true do
#       visit conversation_path(conversation)
#
#       choose "rating_score_8"
#       click_button "Rate"
#
#       expect(page).to have_content("8", count: 2)
#     end
#   end
# end
