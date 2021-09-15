class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  
  validates_presence_of :name, message: 'يجب ادخال الاسم.'

  has_many :appointments
  has_and_belongs_to_many :roles

  def add_role(code)
    role = Role.find_by_code(code)
    self.roles.clear
    self.roles << role
    self.save
  end

  def has_role?(code)
    role = Role.find_by_code(code)
    return true if self.roles.include? role 
    false
  end
end
