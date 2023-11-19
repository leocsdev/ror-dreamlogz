class DreamsController < ApplicationController
  before_action :set_dream, only: %i[show edit update destroy]
  before_action :get_week_date_range, only: :index

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

  def get_week_date_range
    @dates = []
    @current_date = Date.current

    # Get the last 3 days and the next 3 days of the current date
    # e.g. if today is the 4th, get the 1st to 7th date range
    (Date.current.days_ago(3)..Date.current.days_since(3)).each do |date|
      @dates << date
    end
  end
end
