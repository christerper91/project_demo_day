class BookingsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
    @days = (@booking.end_date - @booking.start_date).floor/(60*60*24)
  end

  def new
    @booking = current_user.bookings.build
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def create
    @booking = current_user.bookings.build(booking_params)
    if @booking.save
      redirect_to new_customer_url(booking_id: @booking.id), notice: "Booking was successfully created, Add Your Customer Detail"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @bookings = Booking.find(params[:id])
    @bookings.update(booking_params)
    if @bookings.save
      redirect_to @bookings, notice: "Booking was successfully updated"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookings = Booking.find(params[:id])
    @bookings.destroy
    redirect_to @bookings, notice: "Booking was successfully deleted"
  end

  def correct_user
    @booking = current_user.bookings.find_by(id: params[:id])
    redirect_to bookings_path, notice: "Not Authorize User To Perform This Action" if @booking.nil?
  end

  private
  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :pickup_location, :dropoff_location)
  end
end
