class Company
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String

  # belongs_to :feedback
  has_many :crackers
end
