class CustomersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]
  def index
    @customers = Customer.all
  end

  def show

    @customer = Customer.find(params[:id])
    @booking = @customer.booking
    @days = (@booking.end_date - @booking.start_date).floor/(60*60*24)

  end

  def new
    @customer = Customer.new(booking_id: params[:booking_id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def create
    @customer = current_user.customers.build(customer_params)
    @booking = @customer.booking
    if @customer.save
      redirect_to new_supplier_url(customer_id: @customer.id, booking_id: @booking.id), notice: "Customer was successfully created, Please Add Your Supplier "
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @customers = Customer.find(params[:id])
    @customers.update(customer_params)
    if @customers.save
      redirect_to @customers, notice: "Customer was successfully Updated"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @customers = Customer.find(params[:id])
    @customers.destroy
    redirect_to @customers, notice: "Customer was successfully deleted"
  end

  def correct_user
    @customer = current_user.customers.find_by(id: params[:id])
    redirect_to customers_path, notice: "Not Authorize User To Perform This Action" if @customer.nil?
  end

  private
  def customer_params
    params.require(:customer).permit(:name, :contact, :email, :customer_ic, :customer_license, :booking_id)
  end
end
