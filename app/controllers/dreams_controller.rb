class DreamsController < ApplicationController
  def index
    @dreams = Dream.today
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

  def show
    @dream = Dream.find(params[:id])
  end
  

  private

  def dream_params
    params.require(:dream).permit(:title, :body)
  end
end
