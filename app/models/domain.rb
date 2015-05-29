class Domain < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  enum status: [:registered, :available]
end
