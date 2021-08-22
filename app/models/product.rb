class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :price, type: Integer
  field :stock, type: Boolean
  field :details, type: String
  field :description, type: String

  has_and_belongs_to_many :tags
end
