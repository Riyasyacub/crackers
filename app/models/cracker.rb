class Cracker
  include Mongoid::Document
  include Mongoid::Timestamps
  field :code, type: String
  field :name, type: String
  field :price, type: Integer
  field :type, type: String
  field :description, type: String
  belongs_to :company
  # belongs_to :cracker
end
