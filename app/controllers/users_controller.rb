class UsersController < ApplicationController
  include Shared::Utils

  def index
    @users = User.select('id,user_name,real_name,email_address,phone_number,active,admin,created_at,updated_at')

    # ensure we return an empty set if it's blank
    if @users.size == 0
      @users = {}
    end

    render json:@users
  end

  def create
		@user = User.new(user_params)

    if @user.valid?
      @user.save
			@obj = @user
			@status = 200
		else
      ERROR_LOGGER.info @user.errors.full_messages
			@obj = {'error': 'User is invalid', 'fields': @user.errors.messages.keys, 'messages': @user.errors.full_messages}
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
        @user = User.find(id)
      rescue ActiveRecord::RecordNotFound
        # we capture and ignore this exception to avoid the default 404 handler page and handle it ourselves
      end

      # handle user found
      if !@user.nil? && @user.class == User
        # try to update user
        if @user.update_attributes(user_params)
          @obj = @user
          @status = 200
        else
          @obj = {'error': 'User is invalid', 'fields': @user.errors.messages.keys, 'messages': @user.errors.full_messages}
          @status = 400
        end

      # handle user_id is invalid
      else
        @obj = {"error":"User with that id does not exist."}
        @status = 404
      end

    # deal with strange/esoteric id field
    else
      @obj = {"error":"User with that id does not exist."}
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
        @obj = User.find(id)
      rescue ActiveRecord::RecordNotFound
        # we capture and ignore this exception to avoid the default 404 handler page and handle it ourselves
      end

      # handle user found
      if !@obj.nil? && @obj.class == User
        @status = 200

      # handle user does not exist
      else
        @obj = {"error":"User with that id does not exist."}
        @status = 404
      end

    # handle user_id is invalid
    else
      @obj = {"error":"User with that id does not exist."}
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
        @obj = User.find(id)
      rescue ActiveRecord::RecordNotFound
        # we capture and ignore this exception to avoid the default 404 handler page and handle it ourselves
      end

      # handle user found
      if !@obj.nil? && @obj.class == User && @obj.destroy
        @status = 200
        @obj = {}

      # handle user does not exist
      else
        @obj = {"error":"User with that id does not exist."}
        @status = 404
      end

    # handle user_id is invalid
    else
      @obj = {"error":"User with that id does not exist."}
      @status = 404
    end

    render :json => @obj, :status => @status
  end

  private
    def user_params
      params.require(:user).permit(:real_name, :email_address, :phone_number, :user_name, :password, :password_confirmation)
    end


end
