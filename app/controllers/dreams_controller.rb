# frozen_string_literal: true

class DreamsController < ApplicationController
  before_action :set_dream, only: %i[show edit update destroy]
  before_action :generate_week_date_range, only: :index

  def index
    # Parse date from params
    date = parse_date(params[:date])

    return @dreams = Dream.today if date.nil?

    # Query all dreams only from the date selected
    @dreams = Dream.where(created_at: date.beginning_of_day..date.end_of_day)
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

  def generate_week_date_range
    # Parse date from params
    selected_date = parse_date(params[:date])
    @dates = []

    # If date is nil, set the current date
    @selected_date = selected_date || Date.current

    # Get the last 3 days and the next 3 days of the current date
    # e.g. if today is the 4th, get the 1st to 7th date range
    (@selected_date.days_ago(3)..@selected_date.days_since(3)).each do |date|
      @dates << date
    end
  end

  def parse_date(date)
    parsed_date = Date.parse(date)
    # if parsed_date is in the future, return current date
    return Date.current if parsed_date > Date.current

    parsed_date
  rescue StandardError
    # if date is invalid, return nil
    nil
  end
end
