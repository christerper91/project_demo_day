class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.references :booking, foreign_key: true
      t.string :name
      t.integer :contact
      t.string :email

      t.timestamps
    end
  end
end
