require 'rails_helper'

describe "User" do
	describe "GET /signup" do
		it "displays the signup form" do
			visit sign_up_path
			page.should have_content 'Sign up'
		end
	end
end