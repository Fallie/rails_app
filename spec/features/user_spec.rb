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

		it 'hides the root user from the list' do 
			root_user = create(:test_user)
			visit sign_in_path
			page.should have_content 'Sign in'
			fill_in 'session[email]', with: root_user.email
			fill_in 'session[password]', with: root_user.password
			click_button 'Sign in'	
			click_link 'Users'	
			expect(page).to_not have_css("#table", :text => root_user.name)
		end

		context 'not hides users other than root user from the list' do
			it 'has a patinet user' do
				root_user = create(:test_user)
				user = create(:second_test_user)
				visit sign_in_path
				page.should have_content 'Sign in'
				fill_in 'session[email]', with: root_user.email
				fill_in 'session[password]', with: root_user.password
				click_button 'Sign in'	
				click_link 'Users'
				expect(page).to have_css("#table", :text => user.name)
			end
		end
	end
end