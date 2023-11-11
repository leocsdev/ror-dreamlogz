class DreamsController < ApplicationController
  before_action :set_dream, only: %i[show edit update destroy]
  before_action :get_days_of_current_month, only: :index

  def index
    @dreams = Dream.today
  end

  def new
    @dream = Dream.new
  end

  def create
    @dream = Dream.new(dream_params)

    if @dream.save
      respond_to do |format|
        format.html { redirect_to dreams_path, success: "Your dream has been saved." }
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end
  
  def edit; end

  def update
    if @dream.update(dream_params)
      redirect_to dreams_path, success: "Your dream has been updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @dream.destroy

    respond_to do |format|
      format.html { redirect_to dreams_path, success: "Your dream has been deleted." }
      format.turbo_stream
    end
  end

  private

  def set_dream
    @dream = Dream.find(params[:id])
  end

  def dream_params
    params.require(:dream).permit(:title, :body)
  end

  def get_days_of_current_month
    @days = []

    @current_day = Date.current.strftime("%d")

    (Date.current.beginning_of_month..Date.current.end_of_month).each do |date|
      @days << date.strftime("%d")
    end
  end
end
