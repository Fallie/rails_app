require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #new' do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
  	let(:password) {'123123'}
    let(:password_confirmation) {'123123'}
    let(:params) do
      {
        user:{
          name: 'test',
          email: 'test@gmail.com',
          password: password,
          password_confirmation: password_confirmation,
          role: 'patient'
        }
      }
  	end

  	subject{ post :create, params: params }
  	it 'creates a record' do
  		subject
      expect(User.count).to eq 1
  	end

    it 'returns http success' do
      subject
      expect(response).to have_http_status(302)
    end

    it 'creates a patient' do
      subject
      expect(User.first.role).to eq 'patient'
    end

    context 'fail to save' do
      let(:password_confirmation) {''}
      it 'stay at the same page' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'fail to add a new record' do
        subject
        expect(User.count).to eq 0
      end
    end

  end

  describe 'PUT #update' do
    let(:password_confirmation) {'password'}
    subject{ put :update,  params:
      {
        id: 1,
        user: {
            name: 'new',
            email: 'new@gmail.com',
            password: 'password',
            password_confirmation: password_confirmation,
          }
      }}
    before do
      sign_in_as(create(:test_user))
    end
      
    it 'updates users name' do
      subject
      expect(User.first.name).to eq 'new'
    end

    it 'updates users email' do
      subject
      expect(User.first.email).to eq 'new@gmail.com'
    end

    it 'returns http success' do
      subject
      expect(response).to have_http_status(302)
    end

    

    context 'fail to update' do
      let(:password_confirmation) {''}
      it 'stay at the same page' do
        subject
        expect(response).to have_http_status(:success)
      end

      it 'fail to update the user' do
        subject
        expect(User.first.name).not_to eq 'new'
      end
    end

  end



end
