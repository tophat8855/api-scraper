# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

response = RestClient.get('http://gschool.github.io/student-apis/')
page = Nokogiri::HTML(response.body)
links = page.css('a')
links.each do |link|
  url = link.attr('href') + 'all'
  data = RestClient.get(url).body
  result = JSON.parse(data)
  result.each do |movie|
   Movie.create(title: movie["title"], year: movie["year"], plot: movie["plot"], image_url: movie["image_url"])
  end
end
