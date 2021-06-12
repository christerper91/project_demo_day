class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def show
    if user_signed_in?
      @booking = Booking.find(params[:id])
      @days = (@booking.end_date - @booking.start_date).floor/(60*60*24)
    else
      redirect_to root_path, notice: "You must login to view this pages"
    end
  end

  def new
    @booking = Booking.new
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def create
    if user_signed_in?
      @booking = current_user.bookings.build(booking_params)
      if @booking.save
        redirect_to new_customer_url(booking_id: @booking.id), notice: "Booking was successfully created, Add Your Customer Detail"
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to root_path, notice: "You must login to view this pages"
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
