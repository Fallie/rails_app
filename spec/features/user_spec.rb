require 'rails_helper'


describe "User" do
	describe "Access to user#index" do

		it "displays the Users link for root user" do
			user = create(:test_user)
			visit sign_in_path
			page.should have_content 'Sign in'
			fill_in 'session[email]', with: user.email
			fill_in 'session[password]', with: user.password
			click_button 'Sign in'			
			page.should have_content 'Users'
		end

		context 'not displays the Users link' do
			it 'is a non root user' do
			user = create(:second_test_user)
			visit sign_in_path
			page.should have_content 'Sign in'
			fill_in 'session[email]', with: user.email
			fill_in 'session[password]', with: user.password
			click_button 'Sign in'			
			page.should_not have_content 'Users'
			end
		end
	end
end