class DogsController < ApplicationController
  before_action :set_user
  before_action :set_dog, only: [:show, :update, :destroy]
  before_action :authenticate 

  def index
    render json: Dog.all
  end

  def show 
    render json: @dog
  end

  def create 
    @dog = Dog.create(dog_params)
    render json: @dog
  end

  def update
    @dog.update(dog_params)
    render json: @dog
  end

  def destroy
    @dog.destroy
    head :no_content
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_dog
      @dog = Dog.find(params[:id])
    end

    def dog_params
      params.require(:dog).permit(:name, :age, :gender, :user_id)
    end
end