require 'rails_helper'

RSpec.describe AnalyticsController, type: :controller do
  before :each do
    request.env["HTTP_ACCEPT"] = 'application/json'
    request.env["HTTP_CONTENT_TYPE"] = 'application/json'

    # analytic exists
    @analytic_success_saved = Analytic.create(FactoryGirl.attributes_for(:analytic))       # analytic object
    @analytic_fail_built = Analytic.new(FactoryGirl.attributes_for(:analytic, :bad_analytic))   # hash of attribs
  end

  describe "GET #index" do
    it "returns http success and have the test analytic name" do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to match(@analytic_success_saved.analytic_name)
      expect { JSON.parse(response.body) }.not_to raise_exception
    end

    it "should return http fail if not json content type" do
      get :index, { :format => :html }
      expect(response).to have_http_status(406)
    end
  end



  describe "POST #create" do
    it "returns http 200 and creates a new user when given correct analytic" do
      a = FactoryGirl.attributes_for(:analytic)
      post :create, params: { analytic: a }
      expect(response).to have_http_status(200)
      expect(response.body).to match(/#{a['analytic_name']}/)
    end

    it "returns http 400 and appropriate error codes when given an incorrect analytic" do
      a = FactoryGirl.attributes_for(:analytic, :bad_analytic)
      post :create, params: { analytic: a }
      expect(response).to have_http_status(400)
      expect(response.body).to match("Analytic is invalid")
      expect(response.body).to match("fields")
      expect(response.body).to match("tlp")
    end
  end

  describe "PUT #update" do
    before :each do
      @correct_analytic_blob = FactoryGirl.attributes_for(:analytic)
      @incorrect_analytic_blob = FactoryGirl.attributes_for(:analytic, :bad_analytic)
      @correct_analytic_id = @analytic_success_saved.id
    end

    it "returns http 200 and returns the updated analytic given a correct analytic blob and id" do
      put :update, params: { id: @correct_analytic_id, analytic: @correct_analytic_blob }
      expect(response).to have_http_status(200)
      expect(response.body).to match(@correct_analytic_blob[:analytic_name])
    end

    it "returns http 400 and the appropriate error message when given incorrect analytic blob and correct id" do
      put :update, params: { id: @correct_analytic_id, analytic: @incorrect_analytic_blob }
      expect(response).to have_http_status(400)
      expect(response.body).to match("Analytic is invalid")
      expect(response.body).to match("fields")
      expect(response.body).to match("tlp")
    end

    it "returns http 404 and the appropriate error message when given correct analytic blob and incorrect id" do
      put :update, params: { id: 333333, analytic: @correct_analytic_blob }
      expect(response).to have_http_status(404)
      expect(response.body).to match("Analytic with that id does not exist.")
    end
  end


  describe "GET #Show" do
    it 'should return http success and an analytic data blob on success' do
      get :show, params: { id: @analytic_success_saved.id }
      expect(response).to have_http_status(200)
      expect(response.body).to match(/#{@analytic_success_saved['analytic_name']}/)
    end

    it 'should return http 404 and the correct error if id is invalid type' do
      get :show, params: { id: 'aaa' }
      expect(response).to have_http_status(404)
      expect(response.body).to match("Analytic with that id does not exist.")
    end

    it 'should return http 404 and the correct error if id is non-valid integer' do
      get :show, params: { id: 33333333 }
      expect(response).to have_http_status(404)
      expect(response.body).to match("Analytic with that id does not exist.")
    end
  end

  describe "DELETE #destroy" do
    it "returns http 200 and the appropriate error message when given correct id" do
      delete :destroy, params: { id: @analytic_success_saved.id }
      expect(response).to have_http_status(200)
    end

    it "returns http 404 and the appropriate error message when given incorrect id" do
      delete :destroy, params: { id: 333333 }
      expect(response).to have_http_status(404)
      expect(response.body).to match("Analytic with that id does not exist.")
    end

    it "returns http 404 and the appropriate error message when given badly formatted id" do
      delete :destroy, params: { id: 'aa' }
      expect(response).to have_http_status(404)
      expect(response.body).to match("Analytic with that id does not exist.")
    end
  end
end
