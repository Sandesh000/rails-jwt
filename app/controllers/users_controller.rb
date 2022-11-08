class UsersController < ApplicationController
  before_action :authorize_request, except: %i[create index]
  before_action :find_user, except: %i[create index]

  # GET /users

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  # GET /users/{username}
  def show

    render json: @user, status: :ok
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{username}
  def update
    
    if @decoded["user_id"] == @user.id
      if @user.update(user_params)
        render json: @user, status: :ok
      else @user.update(user_params)
        render json: { errors: @user.errors.full_messages },
               status: :unprocessable_entity
      end
    else
      render json: { errors: 'you are not authorize to update this users'}
    end
  end

  # DELETE /users/{username}
  def destroy
    if @decoded["user_id"] == @user.id
      @user.destroy
      render json: {messages:"user deleted successfully"}
    else
        render json: { errors: 'you are not authorize to update this users'}
    end

  end

  private

  # def find_user
  #   @user = User.find_by_username!(params[:_username])
  #   rescue ActiveRecord::RecordNotFound
  #     render json: { errors: 'User not found' }, status: :not_found
  # end

  def user_params
    params.permit(
       :name, :username, :email, :password, :password_confirmation, :avatar
    )
  end
end