require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(302)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(302)
    end
  end

  describe "POST #create" do

    context 'fails to create user' do
        it 'not the patient' do
          create(:second_test_user)
          user = create(:third_test_user)
          attrs = attributes_for(:test_appointment)
          sign_in_as(user)
          expect{ post :create, params: attrs }.to raise_error ActionController::RoutingError
        end
    end
  end



end
