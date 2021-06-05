class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.references :booking, foreign_key: true
      t.references :user, foreign_key: true
      t.references :customer, foreign_key: true
      t.references :supplier, foreign_key: true
      t.string :type_of_car
      t.string :car_plate_no
      t.integer :car_agent_rate
      t.integer :car_selling_rate

      t.timestamps
    end
  end
end
