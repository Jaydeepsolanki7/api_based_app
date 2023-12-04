class User < ApplicationRecord
  include SearchCop
  validates :name, presence: true
  validates :email, presence: true
  validates :age, presence: true
  
  search_scope :search do
    attributes :name
  end

  enum :user_type, [:admin, :user]
end
