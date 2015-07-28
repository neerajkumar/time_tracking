class Employee < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :confirmable, :recoverable, stretches: 20

  has_and_belongs_to_many :projects

  def is_admin?
    self.role == "admin"
  end

  def fullname
    self.first_name + " " + self.last_name
  end
  
end
