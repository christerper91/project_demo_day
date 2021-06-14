class ChangeIntegerLimitInSuppliersTable < ActiveRecord::Migration[6.1]
  def change
    change_column :suppliers, :company_number_account, :integer, limit: 8
  end
end
