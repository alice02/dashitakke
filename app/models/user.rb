class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :answers, dependent: :destroy
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :papers

  def has_role?(name)
    self.roles.where(name: name).length > 0
  end

end
