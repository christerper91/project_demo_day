class CreateSuppliers < ActiveRecord::Migration[6.1]
  def change
    create_table :suppliers do |t|
      t.references :booking, foreign_key: true
      t.references :user, foreign_key: true
      t.references :customer, foreign_key: true
      t.string :company_name
      t.integer :company_contact
      t.string :company_email
      t.string :company_bank_account
      t.integer :company_number_account

      t.timestamps
    end
  end
end
