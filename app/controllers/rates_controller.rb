# coding: utf-8
class RatesController < ApplicationController
	def index
		@volumes = Category.where(type: "volume").sort!
		@places = Category.where(type: "place").sort!
	end
	def show
		rating = Rate.new
		cat_id = params[:id]
		start_month = params[:date] != nil ? params[:date][:month] : Date.today.month - 1
		start_year	= params[:date] != nil ? params[:date][:year] : Date.today.year
		company = params[:company] || []


		@category = Category.find(cat_id)
		@companies = rating.get_companies(cat_id)
		@rate = Array.new

		@rating = rating.get_rating_data(cat_id, start_year, start_month, @category.type)

		@rating.each do |item|
			company.each do |i|
				@rate.push({ :label => item['_id'], :data => item['value'].sort }) if item['_id'] === i
			end
		end

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
		months = [7,8]
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
							name = item.css("td:nth-child(2)").text.gsub(/[U+00ABU+00BBU+0022«»"”]/, '').gsub(/\s{2,}/, ' ').strip.mb_chars.upcase
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
