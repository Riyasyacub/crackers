class Tag
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  has_and_belongs_to_many :category
  has_and_belongs_to_many :products
end
