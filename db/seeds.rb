# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.delete_all
Product.create(title: 'Tag gun', 
	description: %{ <p>Tag gun desc Tag gun desc gun desc Tag gun desc gun desc Tag gun desc gun desc 
					gun desc Tag gun desc gun desc Tag gun desc gun desc Tag gun desc gun desc Tag gun desc 
					gun desc Tag gun desc gun desc Tag gun desc gun desc Tag gun desc Tag gun desc </p>},
	image_url: 'http://images.prom.ua/14213866_w200_h200_tpg.jpg',
	price: 40
)
Product.create(title: 'Tag pin', 
	description: %{ <p>Tag pin desc Tag pin desc pin desc Tag pin desc pin desc Tag pin desc pin desc 
					pin desc Tag pin desc pin desc Tag pin desc pin desc Tag pin desc pin desc Tag pin desc 
					pin desc Tag pin desc pin desc Tag pin desc pin desc Tag pin desc Tag pin desc </p>},
	image_url: 'http://images.prom.ua/14213840_w200_h200_tpp.jpg',
	price: 28
)