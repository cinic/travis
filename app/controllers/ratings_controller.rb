# coding: utf-8
class RatingsController < ApplicationController
	def index
		#@rating = Rating.find(params[:category]) if params[:category]
		@ratings = Category.all
	end

	def show
		@companies = Array.new()
		@category = Category.find(params[:id])
		@month = Date.today - 1.month
		@year = Date.today.year
		@rating = Hash.new()
		@m = Array.new()
		@y = Array.new()
		@c = Array.new()
		#pattern = "открытие"

		pattern = params[:utf8] && params[:company] ? params[:company] : "открытие"

		@items = Rating.where(:category => params[:id])
		@items.distinct(:date).each	do |d| 
			@m.push([Time.at(d.to_i).strftime('%B'),Time.at(d.to_i).strftime('%m')])
			@y.push(Time.at(d.to_i).strftime('%Y'))
		end
		@items.distinct(:company).each	do |d| 
			@c.push(d.to_s)
		end
		@m.uniq! && @y.uniq! && @c.uniq!
		#@datetime[:years].uniq
		
		#if params[:date]
		#	@month = params[:date][:month].to_i
		#	@year = params[:date][:year].to_i
		#	@rating = Rating.where(:category => params[:id], :date => params[:date][:month].to_s + '.' + params[:date][:year].to_s)
		#end
		#@rating = Rating.all
		#@rating = Rating.all.distinct(:company)
		#@rating.uniq {|t| t.company}
		#@rating.each do |item|
			#row = Rating.find(item._id).update(company: item.company.gsub!(/[«»"]/, ''))
		#	row = Rating.find(item._id)
		#	comp = item.company.gsub(/[«»"”]/, '')
			#row.update_attribute(:company, comp) ? Rails.logger.debug("Object: #{comp.inspect}") : Rails.logger.debug("Object: не был добавлен")
		#end

		Rails.logger.debug("Object: #{pattern}")
		@rating[:items] = Rating.where(:category => params[:id])
		#@rating[:min_date] = params[:date] ? {:date => Date.new(params[:date]["start_year"].to_i, params[:date]["start_month"].to_i).end_of_month().to_time.to_i} : @rating[:items].min { |a,b| a[:date] <=> b[:date] }
		#@rating[:max_date] = params[:date] ? {:date => Date.new(params[:date]["end_year"].to_i, params[:date]["end_month"].to_i).end_of_month().to_time.to_i} : @rating[:items].max { |a,b| a[:date] <=> b[:date] }
		@rating[:min_date] = @rating[:items].min { |a,b| a[:date] <=> b[:date] }
		@rating[:max_date] = @rating[:items].max { |a,b| a[:date] <=> b[:date] }

		respond_to do |format|
			format.html
			format.json { render json: @rating }
		end
	end

	# GET /rating/new
	# GET /rating/new.json
	def new
		#@rating = Rating.new
		categories = Category.all
		years = [2013]
		months = [1,2,3,4,5]
		@data = Array.new()
		
		if params[:utf8] && params[:commit]
			require "open-uri"
			#month = params[:date][:month].to_s
			#year = params[:date][:year].to_s
			#category = Category.find(params[:category])
			categories.each	do |cat|
				years.each do |year|
					months.each do |month|
						@docs = Nokogiri::HTML(open(cat.url + '&month=' + month.to_s + '&year=' + year.to_s))
						@docs.css(".table1 tr").each do |item|
							place = item.css("td:nth-child(1)").text
							name = item.css("td:nth-child(2)").text
							volume = item.css("td:nth-child(3)").text

							#@data.push({:date => Date.new(year, month).end_of_month.to_time.to_i, :company => name.to_s.gsub(/[^\w\s\-\+]/, ""), :place => place.to_i, :volume => volume.to_s.gsub(/\D/, '').to_i, :category => cat._id}) unless place == ""
							@rating = Rating.create({:date => Date.new(year, month).end_of_month.to_time.to_i, :company => name.to_s.gsub(/[U+00ABU+00BBU+0022«»"”]/, "").strip, :place => place.to_i, :volume => volume.to_s.gsub(/\D/, '').to_i, :category => cat._id}) unless place == "" || name == ""
							#Rails.logger.debug("My object: #{@rating.inspect}")
							#@rating = Rating.new([:date => Date.new(year, month).end_of_month.to_time.to_i, :company => name.to_s.gsub(/[^\w\s\-\+]/, ""), :place => place.to_i, :volume => volume.to_s.gsub(/\D/, '').to_i, :category => cat._id]) unless place == ""
							#if @rating.save 
								
							#end
						end
						#@ratings = Rating.create(@data) unless @data.length == 0
					end
				end
			end
		end

		respond_to do |format|
			format.html 
			format.json { render json: @rating }
		end
	end

	# POST /prospects
	# POST /prospects.json
	def create
		@rating = Rating.new(params[:data])

		respond_to do |format|
			if @rating.save
				format.html { redirect_to @rating, notice: 'Prospect was successfully created.' }
				format.json { render json: @rating, status: :created, location: @rating }
			else
				format.html { render action: "new" }
				format.json { render json: @rating.errors, status: :unprocessable_entity }
			end
		end
	end

end
