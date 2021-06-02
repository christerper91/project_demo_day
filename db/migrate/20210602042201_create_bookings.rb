class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.string :pickup_location
      t.string :dropoff_location

      t.timestamps
    end
  end
end
