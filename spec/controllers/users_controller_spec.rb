require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before :each do
    request.env["HTTP_ACCEPT"] = 'application/json'
    request.env["HTTP_CONTENT_TYPE"] = 'application/json'

    # user exists
    @user_success_saved = User.create!(FactoryGirl.attributes_for(:user))       # user object
    @user_fail_built = User.new(FactoryGirl.attributes_for(:user, :bad_user))   # hash of attribs
  end

  describe "GET #index" do

    it "returns http success and have the test user name" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to match("714-332-1234")
      expect { JSON.parse(response.body) }.not_to raise_exception
    end

    it "should return http fail if not json content type" do
      get :index, { :format => :html }
      expect(response).to have_http_status(406)
    end
  end

  describe "GET #Show" do
    it 'should return http success and a user data blob on success' do
      get :show, params: { id: @user_success_saved.id }
      expect(response).to have_http_status(200)
      expect(response.body).to match(/#{@user_success_saved['user_name']}/)
    end

    it 'should return http 404 and the correct error if id is invalid type' do
      get :show, params: { id: 'aaa' }
      expect(response).to have_http_status(404)
      expect(response.body).to match("User with that id does not exist.")
    end

    it 'should return http 404 and the correct error if id is non-valid integer' do
      get :show, params: { id: 33333333 }
      expect(response).to have_http_status(404)
      expect(response.body).to match("User with that id does not exist.")
    end

  end

  describe "POST #create" do
    it "returns http 200 and creates a new user when given correct user" do
      u = FactoryGirl.attributes_for(:user)
      post :create, params: { user: u }
      expect(response).to have_http_status(200)
      expect(response.body).to match(/#{u['user_name']}/)
    end

    it "returns http 400 and appropriate error codes when given an incorrect user" do
      u = FactoryGirl.attributes_for(:user, :bad_user)
      post :create, params: { user: u }
      expect(response).to have_http_status(400)
      expect(response.body).to match("User is invalid")
      expect(response.body).to match("fields")
      expect(response.body).to match("email_address")
    end
  end

  describe "PUT #update" do
    before :each do
      @correct_user_blob = FactoryGirl.attributes_for(:user)
      @incorrect_user_blob = FactoryGirl.attributes_for(:user, :bad_user)
      @correct_user_id = @user_success_saved.id
    end

    it "returns http 200 and returns the updated user given a correct user blob and id" do
      put :update, params: { id: @correct_user_id, user: @correct_user_blob }
      expect(response).to have_http_status(200)
      expect(response.body).to match(@correct_user_blob[:user_name])
    end

    it "returns http 400 and the appropriate error message when given incorrect user blob and correct id" do
      put :update, params: { id: @correct_user_id, user: @incorrect_user_blob }
      expect(response).to have_http_status(400)
      expect(response.body).to match("User is invalid")
      expect(response.body).to match("fields")
      expect(response.body).to match("email_address")
    end

    it "returns http 404 and the appropriate error message when given correct user blob and incorrect id" do
      put :update, params: { id: 333333, user: @correct_user_blob }
      expect(response).to have_http_status(404)
      expect(response.body).to match("User with that id does not exist.")
    end
  end

  describe "DELETE #destroy" do
    it "returns http 200 and the appropriate error message when given correct id" do
      delete :destroy, params: { id: @user_success_saved.id }
      expect(response).to have_http_status(200)
    end

    it "returns http 404 and the appropriate error message when given incorrect id" do
      delete :destroy, params: { id: 333333 }
      expect(response).to have_http_status(404)
      expect(response.body).to match("User with that id does not exist.")
    end

    it "returns http 404 and the appropriate error message when given badly formatted id" do
      delete :destroy, params: { id: 'aa' }
      expect(response).to have_http_status(404)
      expect(response.body).to match("User with that id does not exist.")
    end
  end

end
