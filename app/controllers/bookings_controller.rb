class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
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
      redirect_to @bookings, notice: "Booking was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookings = Booking.find(params[:id])
    @bookings.destroy

  end

  private
  def booking_params
    params.require(:booking).permit(:description, :rate, :bathroom, :wifi, photos: [])
  end
end
