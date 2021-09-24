class Order
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type:String
  field :phone, type:String
  field :address, type:String
  field :cart, type:Hash
end
