# coding: utf-8
class RatesController < ApplicationController
	def index
		@cats = Category.all
	end

	def show
		@category = Category.find(params[:id])
		@rating = Hash.new()
		@c = Array.new()
		year = params[:year]
		month = params[:month]
		pattern = params[:company]
		@rate = Array.new()

		@items = Rate.where(cat_id: params[:id])
		@y = @items.distinct(:y)
		@m = @items.distinct(:m)


		@items.each	do |d|
			d.items.each do |i|
				@c.push(i['c'].strip)
			end
		end

		@m.uniq!
		@y.uniq!
		@c.uniq!.sort!()
		@m.sort!()
		

		map = %Q{
			function() {
				var values = []
				for ( var i in this.items) {

					//emit({c: this.items[i].c, cat: this.cat_id}, {d:[this.y.toString() + '-' + this.m.toString(), this.items[i].v]});
					emit(this.items[i].c, [new Date(this.y, this.m - 1, 1).getTime().toFixed(0), this.items[i].v*1,this.items[i].p*1]);
					//emit(this.items[i].c, [this.y.toString() + '-' + this.m.toString(), this.items[i].v*1]);
				}
				
			}
		}

		reduce = %Q{
			function(key, values) {
				var res = [];
				
				
				return {v: values};
			}
		}
		func = %Q{
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

		@rating = Rate.where(cat_id: params[:id], :y.gte => year, :m.gte => month).map_reduce(map, reduce).finalize(func).out(inline: true)
		#@rt = @rating.where("_id.cm" => /pattern/ui)
		@rate = []
		@rating.each do |item|
			if pattern.is_a? Array
				pattern.each do |i|
					@rate.push({ :label => item['_id'], :data => item['value'].sort }) if item['_id'] === i
				end
			else
				@rate = { :label => item['_id'], :data => item['value'].sort } if item['_id'] === pattern
			end
		end


		#@rating = Rate.where(cat_id: params[:id], :y.gte => year, :m.gte => month)
		#@rating[:min_date] = params[:date] ? {:date => Date.new(params[:date]["start_year"].to_i, params[:date]["start_month"].to_i).end_of_month().to_time.to_i} : @rating[:items].min { |a,b| a[:date] <=> b[:date] }
		#@rating[:max_date] = params[:date] ? {:date => Date.new(params[:date]["end_year"].to_i, params[:date]["end_month"].to_i).end_of_month().to_time.to_i} : @rating[:items].max { |a,b| a[:date] <=> b[:date] }
		#@rating[:min_date] = @rating[:items].min { |a,b| a[:date] <=> b[:date] }
		#@rating[:max_date] = @rating[:items].max { |a,b| a[:date] <=> b[:date] }

		respond_to do |format|
			format.html
			format.json { render json: @rate }
		end
	end

	# GET /rating/new
	# GET /rating/new.json
	def new
		categories = Category.all
		years = [2013]
		months = [1,2,3,4,5,6,7,8]
		@d = Array.new()
		if params[:utf8] && params[:commit]
			require "open-uri"
			categories.each	do |cat|
				years.each do |year|
					months.each do |month|
						@data = Array.new()
						@docs = Nokogiri::HTML(open(cat.url + '&month=' + month.to_s + '&year=' + year.to_s))
						@docs.css(".table1 tr").each do |item|
							place = item.css("td:nth-child(1)").text
							name = item.css("td:nth-child(2)").text.gsub(/[U+00ABU+00BBU+0022«»"”]/, '').gsub(/\s{2,}/, ' ').strip
							volume = item.css("td:nth-child(3)").text != '' ? item.css("td:nth-child(3)").text.gsub(/\D/, '') : nil

							#@data.push({ c: name.to_s.gsub(/[^\w\s\-\+]/, ''), v: volume.to_s.gsub(/\D/, '').to_i}) unless place == '' || name == ''
							@data.push({ c: name.to_s, v: volume, p: place}) unless name == ''
							#@d.push({ c: name.to_s, v: volume, u: cat.url + '&month=' + month.to_s + '&year=' + year.to_s, n: cat.name }) unless place == '' || name == ''
							#@rating = Rating.create({:date => Date.new(year, month).end_of_month.to_time.to_i, :company => name.to_s.gsub(/[U+00ABU+00BBU+0022«»"”]/, "").strip, :place => place.to_i, :volume => volume.to_s.gsub(/\D/, '').to_i, :category => cat._id}) unless place == "" || name == ""
							#Rails.logger.debug("My object: #{@rating.inspect}")

						end
						
						if @data.length > 0
							Rate.create({cat_id: cat._id, y: year.to_i, m: month.to_i, items: @data})
						else
							Rails.logger.debug("Null data: #{cat._id}, #{cat.url}&year=#{year}&month=#{month}")
						end
					end
				end
			end
		end

		respond_to do |format|
			format.html 
			format.json { render json: @data }
		end
	end

	# POST /prospects
	# POST /prospects.json
	def create
		@data = Rate.new(params[:data])

		respond_to do |format|
			if @rating.save
				format.html { redirect_to @data, notice: 'Prospect was successfully created.' }
				format.json { render json: @data, status: :created, location: @data }
			else
				format.html { render action: "new" }
				format.json { render json: @data.errors, status: :unprocessable_entity }
			end
		end
	end

end
