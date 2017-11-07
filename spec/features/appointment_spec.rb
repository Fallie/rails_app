require 'rails_helper'


describe "Appointment" do
	describe "Access to appointment#index" do

		it "displays the +new link for patients" do
			user = create(:second_test_user)
			visit sign_in_path
			page.should have_content 'Sign in'
			fill_in 'session[email]', with: user.email
			fill_in 'session[password]', with: user.password
			click_button 'Sign in'		
			click_link 'Appointments'	
			page.should have_content '+ New'
		end

		context 'not displays the +new link for doctors' do
			it 'is a non root user' do
				user = create(:third_test_user)
				visit sign_in_path
				page.should have_content 'Sign in'
				fill_in 'session[email]', with: user.email
				fill_in 'session[password]', with: user.password
				click_button 'Sign in'		
				click_link 'Appointments'	
				page.should_not have_content '+ New'
			end
		end

		it 'displays the doctors name for patients in upcoming appointments' do 
			user = create(:second_test_user)
			doctor = create(:third_test_user)
			create(:test_appointment)
			visit sign_in_path
			page.should have_content 'Sign in'
			fill_in 'session[email]', with: user.email
			fill_in 'session[password]', with: user.password
			click_button 'Sign in'	
			click_link 'Appointments'		
			expect(page).to have_css("#table", :text => doctor.name)
		end

		context 'not displays the patient name for patients in upcoming appointments' do
			it 'is a patient' do 
				user = create(:second_test_user)
				doctor = create(:third_test_user)
				create(:test_appointment)
				visit sign_in_path
				page.should have_content 'Sign in'
				fill_in 'session[email]', with: user.email
				fill_in 'session[password]', with: user.password
				click_button 'Sign in'	
				click_link 'Appointments'		
				expect(page).to_not have_css("#table", :text => user.name)
			end
		end

		it 'displays the patients name for doctors in upcoming appointments' do 
			patient = create(:second_test_user)
			user = create(:third_test_user)
			create(:test_appointment)
			visit sign_in_path
			page.should have_content 'Sign in'
			fill_in 'session[email]', with: user.email
			fill_in 'session[password]', with: user.password
			click_button 'Sign in'	
			click_link 'Appointments'		
			expect(page).to have_css("#table", :text => patient.name)
		end

		context 'not displays the patient name for patients in upcoming appointments' do
			it 'is a patient' do 
				user = create(:second_test_user)
				doctor = create(:third_test_user)
				create(:test_appointment)
				visit sign_in_path
				page.should have_content 'Sign in'
				fill_in 'session[email]', with: user.email
				fill_in 'session[password]', with: user.password
				click_button 'Sign in'	
				click_link 'Appointments'		
				expect(page).to_not have_css("#table", :text => user.name)
			end
		end

	end
end