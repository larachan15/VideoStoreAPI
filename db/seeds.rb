JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  Customer.create!(customer)
end

JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
  m = Movie.new(movie)
  m.available_inventory = m.inventory
  m.save
end
