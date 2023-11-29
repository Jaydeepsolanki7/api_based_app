class User < ApplicationRecord
  enum :user_type, [:admin, :user]
end
