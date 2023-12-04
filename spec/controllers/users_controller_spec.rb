require "rails_helper"
RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe "GET #index" do
    it "should get a successful response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "should get a successful response" do
      get :show, params: {id: user.id}
      expect(response).to be_successful
    end

    it "assign user to @user" do
      get :show, params: {id: user.id}
      expect(assigns(:user)).to eq(user)
    end

    it "should render format in json" do
      get :show, params: {id: user.id},
      format: :json
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response.media_type).to eq("application/json")
    end
  end
  
  describe "POST #create" do
    it "create a user" do
      post :create, params: {
        user: {
          name: Faker::Name.name,
          email: Faker::Internet.safe_email,
          age: Faker::Number.between(from: 1, to: 100),
          user_type: [:admin, :user].sample
        }
      }
      expect(response).to have_http_status(:success)
      expect(User.count).to eq(1)
    end

    it "should render format in json" do
      post :create, params: {
        user: {
          name: Faker::Name.name,
          email: Faker::Internet.safe_email,
          age: Faker::Number.between(from: 1, to: 100),
          user_type: [:admin, :user].sample
        }
      },
      format: :json
      expect(response.content_type).to eq("application/json; charset=utf-8")
      expect(response.media_type).to eq("application/json")
    end

    it "should recieve a mail" do
      expect { UserMailer.welcome_email(user).deliver }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  describe "PUT #update" do
    it "should update the user" do
      put :update, params: {
        id: user.id,
        user: {
          name: Faker::Name.name,
          email: Faker::Internet.safe_email,
          age: Faker::Number.between(from: 1, to: 100),
          user_type: [:admin, :user].sample
        }
      }

      expect(response).to be_successful
    end
  end

  describe "DELETE #destroy" do
  it "prints the user's name" do
    puts "#{user.name}"
  end
    it "should delete the user" do
      delete :destroy, params: {id: user.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #search" do
    it "should search user by name" do
      debugger
      post :search, params: {name: user.name}

      expect(response).to have_http_status(:success)
    end
  end
end