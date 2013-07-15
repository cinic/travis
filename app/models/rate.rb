class Rate
  include Mongoid::Document
  field :cat_id, type: Moped::BSON::ObjectId
  field :y, type: Integer
  field :m, type: Integer
  field :items, type: Hash
end