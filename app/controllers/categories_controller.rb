class CategoriesController < ApplicationController
  before_action :authorize_request, except: %i[create]
  before_action :find_user_for_categories, except: %i[create]
  def index
    @categories = @user.categories
    render json: @categories, status: :ok

  end

  def show
  end

  def edit
  end
  private
  def find_user_for_categories
    
    @user = User.find_by_username!(params[:user_username])
      rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end
end
