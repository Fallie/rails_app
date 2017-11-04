require 'rails_helper'

describe "User" do
	describe "GET /signup" do
		let(:some_instance) { double(Class_name) }
		let(:results) do

		end

		before do
			allow(some_instance).to receive(:method_name).with().and_return(results)
		end

		it "displays the signup form" do
			visit sign_up_path
			page.should have_content 'Sign up'

			expect(bklwqaw).to  
		end
	end
end