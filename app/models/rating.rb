class Rating
  include Mongoid::Document
  field :date, type: String
  field :company, type: String
  field :volume, type: Integer
  field :place, type: Integer
  field :category, type: String
  
end
