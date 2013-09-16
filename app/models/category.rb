class Category
  include Mongoid::Document
  field :name, type: String
  field :url, type: String
  field :type, type: String
end