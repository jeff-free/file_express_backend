class Sharing < ApplicationRecord
  has_many_attached :files
  has_secure_token
end
