require 'rails_helper'

describe "Home" do
	describe "GET /home" do
		it "displays the welcome" do
			visit static_views_home_path
			page.should have_content 'Welcome to the Rails App!'
		end
	end
end