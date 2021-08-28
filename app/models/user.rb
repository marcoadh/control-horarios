class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy

  # Permite que después que se crea un registro de usuario,
  # automáticamente se ejecute el método set_profile
  after_create :set_profile

  def set_profile
    self.profile = Profile.create()
  end
end
