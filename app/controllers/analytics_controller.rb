class AnalyticsController < ApplicationController
  include Shared::Utils

  def index
    @analytics = Analytic.select('id,analytic_name,analytic,analytic_type,analytic_format,tlp,user_id,version,created_at,updated_at').limit(25)

    # ensure we return an empty set if it's blank
    if @analytics.size == 0
      @analytics = {}
    end

    render json:@analytics
  end

  def create
    @analytic = Analytic.new(analytic_params)

    if @analytic.valid?
      @analytic.save
			@obj = @analytic
			@status = 200
		else
      ERROR_LOGGER.info @analytic.errors.full_messages
			@obj = {'error': 'Analytic is invalid', 'fields': @analytic.errors.messages.keys, 'messages': @analytic.errors.full_messages }
      @status = 400
		end

    render :json => @obj, :status => @status
  end

  def update
    id = params[:id]
    @obj = {}
    @status = 500

    if valid_id(id)
      begin
        @analytic = Analytic.find(id)
      rescue ActiveRecord::RecordNotFound
        # we capture and ignore this exception to avoid the default 404 handler page and handle it ourselves
      end

      # handle user found
      if !@analytic.nil? && @analytic.class == Analytic
        # try to update user
        if @analytic.update_attributes(analytic_params)
          @obj = @analytic
          @status = 200
        else
          @obj = {'error': 'Analytic is invalid', 'fields': @analytic.errors.messages.keys, 'messages': @analytic.errors.full_messages}
          @status = 400
        end

      # handle analytic_id is invalid
      else
        @obj = {"error":"Analytic with that id does not exist."}
        @status = 404
      end

    # deal with strange/esoteric id field
    else
      @obj = {"error":"Analytic with that id does not exist."}
      @status = 404
    end

    render json: @obj, :status => @status
  end

  def show
    id = params[:id]
    @obj = {}
    @status = 500

    if valid_id(id)
      begin
        @obj = Analytic.find(id)
      rescue ActiveRecord::RecordNotFound
        # we capture and ignore this exception to avoid the default 404 handler page and handle it ourselves
      end

      # handle analytic found
      if !@obj.nil? && @obj.class == Analytic
        @status = 200

      # handle analytic does not exist
      else
        @obj = {"error":"Analytic with that id does not exist."}
        @status = 404
      end

    # handle analytic_id is invalid
    else
      @obj = {"error":"Analytic with that id does not exist."}
      @status = 404
    end

    render :json => @obj, :status => @status
  end



    def destroy
      id = params[:id]
      @obj = {}
      @status = 500

      if valid_id(id)
        begin
          @obj = Analytic.find(id)
        rescue ActiveRecord::RecordNotFound
          # we capture and ignore this exception to avoid the default 404 handler page and handle it ourselves
        end

        # handle analytic found
        if !@obj.nil? && @obj.class == Analytic && @obj.destroy
          @status = 200
          @obj = {}

        # handle analytic does not exist
        else
          @obj = {"error":"Analytic with that id does not exist."}
          @status = 404
        end

      # handle analytic_id is invalid
      else
        @obj = {"error":"Analytic with that id does not exist."}
        @status = 404
      end

      render :json => @obj, :status => @status
    end


  private

  def analytic_params
    params.require(:analytic).permit(:analytic_name,:analytic,:analytic_type,:analytic_format,:tlp,:user_id)
  end
end
