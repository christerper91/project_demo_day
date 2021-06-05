class CarsController < ApplicationController
  def index
    @cars = Car.all
  end

  def show
    @car = Car.find(params[:id])
    @detail = @car.booking.customer.supplier
    @days = (@detail.booking.end_date - @detail.booking.start_date).floor/(60*60*24)
  end

  def new
    @car = Car.new(customer_id: params[:customer_id], booking_id: params[:booking_id], supplier_id: params[:supplier_id])
  end

  def edit
    @car = Car.find(params[:id])
  end

  def create
    @car = current_user.cars.build(car_params)
    if @car.save
      redirect_to @car, notice: "car was successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @cars = Car.find(params[:id])
    @cars.update(car_params)
    if @cars.save
      redirect_to @cars, notice: "Car was successfully Updated"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @cars = Car.find(params[:id])
    @cars.destroy

  end

  private
  def car_params
    params.require(:car).permit(:type_of_car, :car_plate_no, :car_agent_rate, :car_selling_rate, :customer_id, :booking_id, :supplier_id)
  end
end