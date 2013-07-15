# coding: utf-8
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'yaml'

url = "http://rts.micex.ru/ru/spot/members-rating.aspx?rid=103&month=5&year=2013"
urls = [{
	name: "Ведущие операторы\r\nАкции: режим основных торгов",
	url: "http://rts.micex.ru/ru/spot/members-rating.aspx?rid=104"
},
{
	name: "Ведущие операторы\r\nАкции: режим переговорных сделок",
	url: "http://rts.micex.ru/ru/spot/members-rating.aspx?rid=104"
},
{
	name: "Ведущие операторы\r\nОбъем клиентских операций",
	url: "http://rts.micex.ru/ru/spot/members-rating.aspx?rid=109"
},
{
	name: "Ведущие операторы\r\nЧисло активных клиентов",
	url: "http://rts.micex.ru/ru/spot/members-rating.aspx?rid=110"
},
{
	name: "Ведущие операторы\r\nЧисло зарегистрированных клиентов",
	url: "http://rts.micex.ru/ru/spot/members-rating.aspx?rid=111"
},
{
	name: "Ведущие операторы\r\nАкции: режим основных торгов T+",
	url: "http://rts.micex.ru/ru/spot/members-rating.aspx?rid=115"
},
{
	name: "Ведущие операторы\r\nОбъем клиентских операций в режиме основных торгов Т+ и РПС с ЦК",
	url: "http://rts.micex.ru/ru/spot/members-rating.aspx?rid=116"
},
{
	name: "Ведущие операторы\r\nОблигации: режим основных торгов и режим переговорных сделок",
	url: "http://rts.micex.ru/ru/spot/members-rating.aspx?rid=112"
},
{
	name: "Ведущие операторы\r\nОФЗ: режим основных торгов и режим переговорных сделок",
	url: "http://rts.micex.ru/ru/spot/members-rating.aspx?rid=113"
},
{
	name: "Ведущие операторы\r\nАкции: режим торгов РЕПО",
	url: "http://rts.micex.ru/ru/spot/members-rating.aspx?rid=105"
},
{
	name: "Ведущие операторы\r\nОблигации: режим торгов РЕПО",
	url: "http://rts.micex.ru/ru/spot/members-rating.aspx?rid=108"
},
{
	name: "Ведущие операторы\r\nОФЗ: режим торгов РЕПО",
	url: "http://rts.micex.ru/ru/spot/members-rating.aspx?rid=114"
},
{
	name: "Лидеры рынка фьючерсов и опционов по объему сделок",
	url: "http://rts.micex.ru/ru/derivatives/members-rating.aspx?rid=1"
},
{
	name: "Лидеры рынка опционов",
	url: "http://rts.micex.ru/ru/derivatives/members-rating.aspx?rid=7"
},
{
	name: "Лидеры рынка фьючерсов и опционов по объему клиентских операций",
	url: "http://rts.micex.ru/ru/derivatives/members-rating.aspx?rid=9"
},
{
	name: "Лидеры рынка фьючерсов и опционов по объему открытых позиций",
	url: "http://rts.micex.ru/ru/derivatives/members-rating.aspx?rid=8"
},
{
	name: "Лидеры рынка фьючерсов и опционов по количеству активных клиентов",
	url: "http://rts.micex.ru/ru/derivatives/members-rating.aspx?rid=10"
},
{
	name: "Лидеры рынка фьючерсов и опционов по приросту клиентов",
	url: "http://rts.micex.ru/ru/derivatives/members-rating.aspx?rid=11"
},
{
	name: "Лидеры фондового рынка секции фьючерсов и опционов по объему сделок",
	url: "http://rts.micex.ru/ru/derivatives/members-rating.aspx?rid=2"
},
{
	name: "Лидеры денежного рынка секции фьючерсов и опционов по объему сделок",
	url: "http://rts.micex.ru/ru/derivatives/members-rating.aspx?rid=3"
},
{
	name: "Лидеры товарного рынка секции фьючерсов и опционов по объему сделок",
	url: "http://rts.micex.ru/ru/derivatives/members-rating.aspx?rid=4"
},
{
	name: "Лидеры биржевого рынка срочных контрактов",
	url: "http://rts.micex.ru/ru/derivatives/members-rating.aspx?rid=6"
}]

doc = Nokogiri::HTML(open(url))
puts doc.at_css("title").text
#YAML::dump(doc)
doc.css(".table1 tr").each do |item|
	place = item.css("td:nth-child(1)").text
	name = item.css("td:nth-child(2)").text
	value = item.css("td:nth-child(3)").text
	#puts item.css("td:nth-child(1)").text
  #price = item.at_css("td").text[/\$[0-9\.]+/]
  puts "#{name} - #{value} - #{place}"
end
