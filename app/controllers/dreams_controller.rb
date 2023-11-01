class DreamsController < ApplicationController
  def index
    
  end

  def new
    @dream = Dream.new
  end

  def create
    @dream = Dream.new(dream_params)

    if @dream.save
      redirect_to dreams_path, success: "Your dream has been saved."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def dream_params
    params.require(:dream).permit(:title, :body)
  end
end
