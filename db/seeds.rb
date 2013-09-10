# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
categories = Category.create([{
	name: "Ведущие операторы\r\nАкции: режим основных торгов",
	url: "http://moex.com/ru/spot/members-rating.aspx?rid=103"
},
{
	name: "Ведущие операторы\r\nАкции: режим переговорных сделок",
	url: "http://moex.com/ru/spot/members-rating.aspx?rid=104"
},
{
	name: "Ведущие операторы\r\nОбъем клиентских операций",
	url: "http://moex.com/ru/spot/members-rating.aspx?rid=109"
},
{
	name: "Ведущие операторы\r\nЧисло активных клиентов",
	url: "http://moex.com/ru/spot/members-rating.aspx?rid=110"
},
{
	name: "Ведущие операторы\r\nЧисло зарегистрированных клиентов",
	url: "http://moex.com/ru/spot/members-rating.aspx?rid=111"
},
{
	name: "Ведущие операторы\r\nАкции: режим основных торгов T+",
	url: "http://moex.com/ru/spot/members-rating.aspx?rid=115"
},
{
	name: "Ведущие операторы\r\nОбъем клиентских операций в режиме основных торгов Т+ и РПС с ЦК",
	url: "http://moex.com/ru/spot/members-rating.aspx?rid=116"
},
{
	name: "Ведущие операторы\r\nОблигации: режим основных торгов и режим переговорных сделок",
	url: "http://moex.com/ru/spot/members-rating.aspx?rid=112"
},
{
	name: "Ведущие операторы\r\nОФЗ: режим основных торгов и режим переговорных сделок",
	url: "http://moex.com/ru/spot/members-rating.aspx?rid=113"
},
{
	name: "Ведущие операторы\r\nАкции: режим торгов РЕПО",
	url: "http://moex.com/ru/spot/members-rating.aspx?rid=105"
},
{
	name: "Ведущие операторы\r\nОблигации: режим торгов РЕПО",
	url: "http://moex.com/ru/spot/members-rating.aspx?rid=108"
},
{
	name: "Ведущие операторы\r\nОФЗ: режим торгов РЕПО",
	url: "http://moex.com/ru/spot/members-rating.aspx?rid=114"
},
{
	name: "Лидеры рынка фьючерсов и опционов по объему сделок",
	url: "http://moex.com/ru/derivatives/members-rating.aspx?rid=1"
},
{
	name: "Лидеры рынка опционов",
	url: "http://moex.com/ru/derivatives/members-rating.aspx?rid=7"
},
{
	name: "Лидеры рынка фьючерсов и опционов по объему клиентских операций",
	url: "http://moex.com/ru/derivatives/members-rating.aspx?rid=9"
},
{
	name: "Лидеры рынка фьючерсов и опционов по объему открытых позиций",
	url: "http://moex.com/ru/derivatives/members-rating.aspx?rid=8"
},
{
	name: "Лидеры рынка фьючерсов и опционов по количеству активных клиентов",
	url: "http://moex.com/ru/derivatives/members-rating.aspx?rid=10"
},
{
	name: "Лидеры рынка фьючерсов и опционов по приросту клиентов",
	url: "http://moex.com/ru/derivatives/members-rating.aspx?rid=11"
},
{
	name: "Лидеры фондового рынка секции фьючерсов и опционов по объему сделок",
	url: "http://moex.com/ru/derivatives/members-rating.aspx?rid=2"
},
{
	name: "Лидеры денежного рынка секции фьючерсов и опционов по объему сделок",
	url: "http://moex.com/ru/derivatives/members-rating.aspx?rid=3"
},
{
	name: "Лидеры товарного рынка секции фьючерсов и опционов по объему сделок",
	url: "http://moex.com/ru/derivatives/members-rating.aspx?rid=4"
},
{
	name: "Лидеры биржевого рынка срочных контрактов",
	url: "http://moex.com/ru/derivatives/members-rating.aspx?rid=6"
}])
