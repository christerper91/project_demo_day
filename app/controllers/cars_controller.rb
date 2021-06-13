class CarsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]
  def index
    @cars = Car.all
  end

  def show
      @car = Car.find(params[:id])
      @detail = @car.booking.customer.supplier
      @days = (@detail.booking.end_date - @detail.booking.start_date).floor/(60*60*24)
      @total_amount_collect = @days * @car.car_selling_rate
      @total_amount_to_pay_supplier =  @car.car_agent_rate * @days
      @profit = @total_amount_collect - @total_amount_to_pay_supplier
  end

  def new
    @car = Car.new(customer_id: params[:customer_id], booking_id: params[:booking_id], supplier_id: params[:supplier_id])
  end

  def edit
    @car = Car.find(params[:id])
  end

  def create
    @car = current_user.cars.build(car_params)
    @detail = @car.booking.customer.supplier
    @days = (@detail.booking.end_date - @detail.booking.start_date).floor/(60*60*24)
    @total_amount_collect = @days * @car.car_selling_rate
    @total_amount_to_pay_supplier =  @car.car_agent_rate * @days
    @profit = @total_amount_collect - @total_amount_to_pay_supplier
    if @car.save
      render :show, notice: "car was successfully created"
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
      redirect_to @cars, notice: "Car was successfully deleted"
  end

  def correct_user
    @car = current_user.cars.find_by(id: params[:id])
    redirect_to cars_path, notice: "Not Authorize User To Perform This Action" if @car.nil?
  end

  private
  def car_params
    params.require(:car).permit(:type_of_car, :car_plate_no, :car_agent_rate, :car_selling_rate, :customer_id, :booking_id, :supplier_id)
  end
end
