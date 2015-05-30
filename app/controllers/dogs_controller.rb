class DogsController < ApplicationController
  private
  def dog_params
    params.require(:dog).permit(:name, :age, :gender, :user_id)
end