class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
    @days = (@booking.end_date - @booking.start_date).floor/(60*60*24)

  end

  def new
    @booking = Booking.new
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def create
    @booking = current_user.bookings.build(booking_params)
    if @booking.save
      redirect_to @booking, notice: "Booking was successfully created"
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

  private
  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :pickup_location, :dropoff_location)
  end
end
