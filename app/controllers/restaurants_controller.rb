class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]
  before_action :restaurant_belongs_to_current_user?, :only => [:edit, :update, :destroy]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.user_id = current_user.id
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
  end

  def update
    @restaurant.update(restaurant_params)
    redirect_to restaurants_path
  end

  def destroy
    if @restaurant.destroy
      flash[:notice] = "Restaurant deleted successfully"
      redirect_to restaurants_path
    else
      flash[:notice] = "Restaurant could not be deleted"
      redirect_to restaurants_path
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description)
  end

  def restaurant_belongs_to_current_user?
    @restaurant = Restaurant.find(params[:id])
    if current_user.id != @restaurant.user_id
      flash[:notice] = "Cannot edit or delete a restaurant you did not create"
      redirect_to root_path
    end
  end

end
