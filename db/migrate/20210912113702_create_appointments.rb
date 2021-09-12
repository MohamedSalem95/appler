class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.string :name, length: 50, null: false
      t.integer :from, null: false
      t.string :department, length: 100
      t.integer :status, default: 1
      t.date :app_date, null: false
      t.time :app_time, null: false
      t.text :description
      t.date :delay_date, null: true
      t.time :approval_time, null: true
      t.timestamps
    end
  end
end
