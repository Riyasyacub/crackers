class Feedback
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :phone_number, type: Integer
  # field :company, type: String
  # field :cracker, type: String
  field :description, type: String

  belongs_to :company
  belongs_to :cracker
end
