class PagesController < ActionController::Base
  def index
    response.headers['Content-Type'] = 'text/html'
    render file: 'public/docs.html'
  end
end
