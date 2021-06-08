class SuppliersController < ApplicationController
  def index
    @suppliers = Supplier.all
  end

  def show
    @supplier = Supplier.find(params[:id])
    @detail = @supplier.booking.customer
    @days = (@detail.booking.end_date - @detail.booking.start_date).floor/(60*60*24)
  end

  def new
    @supplier = Supplier.new(customer_id: params[:customer_id], booking_id: params[:booking_id])
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  def create
    @supplier = current_user.suppliers.build(supplier_params)
    @detail = @supplier.booking.customer
    if @supplier.save
      redirect_to new_car_path(customer_id: @detail.id, booking_id: @detail.booking_id, supplier_id: @supplier.id), notice: "supplier was successfully created, Add your Car Detail"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @suppliers = Supplier.find(params[:id])
    @suppliers.update(supplier_params)
    if @suppliers.save
      redirect_to @suppliers, notice: "Supplier was successfully Updated"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @suppliers = Supplier.find(params[:id])
    @suppliers.destroy

  end

  private
  def supplier_params
    params.require(:supplier).permit(:company_name, :company_contact, :company_email, :company_bank_account, :company_number_account, :customer_id, :booking_id)
  end
end
