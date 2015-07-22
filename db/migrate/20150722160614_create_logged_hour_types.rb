class CreateLoggedHourTypes < ActiveRecord::Migration
  def change
    create_table :logged_hour_types do |t|
      t.string :name
      t.integer :project_id

      t.timestamps
    end
  end
end
