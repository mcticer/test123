class ApplicationController < ActionController::API
  before_action :ensure_json_request

  def ensure_json_request
    return if request.format == :json
    render :json => {'error_message':"This API only accepts json-encoded and -typed requests. Please add the \"Content-Type:application/json\" header to your request and format the data appropriately." }, :status => 406
  end
end
