class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def show
    if user_signed_in?
      @customer = Customer.find(params[:id])
      @booking = @customer.booking
      @days = (@booking.end_date - @booking.start_date).floor/(60*60*24)
    else
      redirect_to root_path, notice: "You must login to view this pages"
    end
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

  end

  private
  def customer_params
    params.require(:customer).permit(:name, :contact, :email, :customer_ic, :customer_license, :booking_id)
  end
end
