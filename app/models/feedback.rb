class Feedback
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :phone_number, type: Number
  field :company, type: String
  field :cracker, type: String
  field :description, type: String
end
