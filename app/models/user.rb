class User < ApplicationRecord
  include SearchCop

  search_scope :search do
    attributes :name
  end

  enum :user_type, [:admin, :user]
end
