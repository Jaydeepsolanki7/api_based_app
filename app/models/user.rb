class User < ApplicationRecord
  enum :user_type, [:admin, :user]

  def self.ransackable_attributes(auth_object = nil)
    ["age", "created_at", "email", "id", "id_value", "name", "updated_at", "user_type"]
  end

end
