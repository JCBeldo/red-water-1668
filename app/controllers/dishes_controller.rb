class DishesController < ApplicationController
  def show
    @dish = Dish.find(params[:id])
  end
  
  def update
    @dish = Dish.find(params[:id])
    @dish.update(dishes_params)

    redirect_to dish_path(@dish)
  end

  private

  def dishes_params
    params.permit(:id)
  end
end