class CarsController < ApplicationController
  def index
    if user_signed_in?
      @cars = Car.all
    else
      redirect_to root_path, notice: "You must login to view this pages"
    end
  end

  def show
    if user_signed_in?
      @car = Car.find(params[:id])
      @detail = @car.booking.customer.supplier
      @days = (@detail.booking.end_date - @detail.booking.start_date).floor/(60*60*24)
      @total_amount_collect = @days * @car.car_selling_rate
      @total_amount_to_pay_supplier =  @car.car_agent_rate * @days
      @profit = @total_amount_collect - @total_amount_to_pay_supplier
    else
      redirect_to root_path, notice: "You must login to view this pages"
    end
  end

  def new
    if user_signed_in?
      @car = Car.new(customer_id: params[:customer_id], booking_id: params[:booking_id], supplier_id: params[:supplier_id])
    else
      redirect_to root_path, notice: "You must login to view this pages"
    end
  end

  def edit
    if user_signed_in?
      @car = Car.find(params[:id])
    else
      redirect_to root_path, notice: "You must login to view this pages"
    end
  end

  def create
    if user_signed_in?
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
    else
      redirect_to root_path, notice: "You must login to view this pages"
    end
  end

  def update
    if user_signed_in?
      @cars = Car.find(params[:id])
      @cars.update(car_params)
      if @cars.save
        redirect_to @cars, notice: "Car was successfully Updated"
      else
        render :new, status: :unprocessable_entity
      end
    else
      redirect_to root_path, notice: "You must login to view this pages"
    end
  end

  def destroy
    if user_signed_in?
      @cars = Car.find(params[:id])
      @cars.destroy
    else
      redirect_to root_path, notice: "You must login to view this pages"
    end

  end

  private
  def car_params
    params.require(:car).permit(:type_of_car, :car_plate_no, :car_agent_rate, :car_selling_rate, :customer_id, :booking_id, :supplier_id)
  end
end
