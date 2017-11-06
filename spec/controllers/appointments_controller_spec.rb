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

  describe "GET #create" do
    it "returns http success" do
    #   put :create
    #   expect(response).to have_http_status(302)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      # post :update
      # expect(response).to have_http_status(302)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      # delete :destroy
      # expect(response).to have_http_status(302)
    end
  end

end
