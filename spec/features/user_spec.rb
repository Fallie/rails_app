require 'rails_helper'

describe "User" do
	describe "GET /signup" do
		it "displays the signup form" do
			visit signup_path
			page.should have_content 'Signup form'
		end
	end
end