class CreateLoggedHours < ActiveRecord::Migration
  def change
    create_table :logged_hours do |t|
      t.integer :hours
      t.datetime :logger_date
      t.integer :employee_id
      t.integer :logged_hour_type

      t.timestamps
    end
  end
end
