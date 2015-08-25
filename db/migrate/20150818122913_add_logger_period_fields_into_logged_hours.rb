class AddLoggerPeriodFieldsIntoLoggedHours < ActiveRecord::Migration
  def change
  	rename_column :logged_hours, :logger_from_date, :logged_from_date if column_exists?(:logged_hours, :logger_from_date)
  	add_column :logged_hours, :logged_to_date, :datetime
  	add_column :logged_hours, :period, :boolean, default: false
  	add_column :logged_hours, :description, :text
  	add_column :logged_hours, :project_id, :integer
  end
end
