class DreamsController < ApplicationController
  before_action :set_dream, only: %i[show edit update destroy]

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

  def show; end
  
  def edit; end

  def update
    if @dream.update(dream_params)
      redirect_to @dream, success: "Your dream has been updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @dream.destroy

    redirect_to dreams_path, success: "Your dream has been deleted."
  end

  private

  def set_dream
    @dream = Dream.find(params[:id])
  end

  def dream_params
    params.require(:dream).permit(:title, :body)
  end
end
