require 'rails_helper'

RSpec.describe "users/new.html.erb", type: :view do
  describe "GET /signup" do

		it "displays the signup form" do
			visit sign_up_path
			page.should have_content 'Sign up'
		end
	end

end
