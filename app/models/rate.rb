class Rate
	include Mongoid::Document
	field :cat_id, type: Moped::BSON::ObjectId
	field :y, type: Integer
	field :m, type: Integer
	field :items, type: Hash



	def get_companies(cat_id)
		Rate.where(cat_id: cat_id).map {|k| k.items}.flatten(1).map {|k| k["c"] }.uniq!.sort!()
	end
	
	def get_rating_data(cat_id, start_year, start_month, place)
		if place == "volume"
			map = map_volume
		else
			map = map_place
		end

		Rate.where(cat_id: cat_id, :y.gte => start_year, :m.gte => start_month).map_reduce(map, reduce).finalize(finalize).out(inline: true)
	end

	private
	def map_volume
		%Q{
			function() {
				for ( var i in this.items) {
					emit(this.items[i].c, [new Date(this.y, this.m - 1, 1).getTime().toFixed(0), this.items[i].v*1]);
				}
				
			}
		}
	end

	def map_place
		%Q{
			function() {
				for ( var i in this.items) {
					emit(this.items[i].c, [new Date(this.y, this.m - 1, 1).getTime().toFixed(0), this.items[i].p*1]);
				}
				
			}
		}
	end

	def reduce
		%Q{
			function(key, values) {
				return {v: values};
			}
		}
	end

	def finalize
		%Q{
			function(key, value) {
				Object.size = function(obj) {
					var size = 0, key;
					for (key in obj) {
						if (obj.hasOwnProperty(key)) size++;
					}
					return size;
				};
				if(Object.size(value) == 1) value = value.v;
				else value = [value];

				return value;
			}
		}
	end
end
