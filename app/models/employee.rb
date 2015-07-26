class Employee < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :confirmable, :recoverable, stretches: 20

  has_and_belongs_to_many :projects

  def admin?
    self.role == "admin"
  end
  
end
