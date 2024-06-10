# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'open-uri'
require 'faker'

puts "Destroying all items..."
Item.destroy_all

# Read the text file and split it into a hash of labeled URLs
image_file_path = File.join(Rails.root, 'app', 'assets', 'image_urls.txt')
image_urls = {}
File.readlines(image_file_path).each do |line|
  key, url = line.split(': ', 2)
  image_urls[key.strip] = url.strip
end

# Array of unique email addresses
email_addresses = []

# Generate unique email addresses for users
5.times do
  email_addresses << Faker::Internet.unique.email
end

# Create Users
User.create([
  { first_name: 'John', last_name: 'Doe', email: email_addresses[0], password: 'password1' },
  { first_name: 'Jane', last_name: 'Smith', email: email_addresses[1], password: 'password2' },
  { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: email_addresses[2], password: 'password3' },
  { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: email_addresses[3], password: 'password4' },
  { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: email_addresses[4], password: 'password5' }
])

# Define categories as an array of strings
categories = ['Strollers', 'Car Seats', 'High Chairs', 'Baby Carriers', 'Baby Toys']

# Define baby item names, descriptions, and image filenames/URLs for each category
stroller_data = {
  names: ['Lightweight Stroller', 'Jogging Stroller', 'Umbrella Stroller', 'Double Stroller', 'Travel Stroller'],
  descriptions: ['Compact and easy to maneuver', 'Designed for active parents', 'Lightweight and portable', 'Accommodates two children', 'Includes car seat and stroller'],
  image_urls: ['stroller1', 'stroller2', 'stroller3', 'stroller4', 'stroller5']
}

car_seat_data = {
  names: ['Infant Car Seat', 'Convertible Car Seat', 'Booster Car Seat', 'All-in-One Car Seat'],
  descriptions: ['Rear-facing for newborns', 'Grows with your child', 'Provides a boost for older kids', 'Adjusts from rear-facing to forward-facing'],
  image_urls: ['car_seat1', 'car_seat2', 'car_seat3', 'car_seat4', 'car_seat5']
}

high_chair_data = {
  names: ['Wooden High Chair', 'Convertible High Chair', 'Portable High Chair', 'Reclining High Chair', 'Adjustable High Chair'],
  descriptions: ['Classic and sturdy design', 'Grows with your child', 'Compact and easy to travel with', 'Reclines for babies comfort', 'Adjustable height and tray'],
  image_urls: ['high_chair1', 'high_chair2', 'high_chair3', 'high_chair4', 'high_chair5']
}

baby_carrier_data = {
  names: ['Wrap Baby Carrier', 'Structured Baby Carrier', 'Soft Structured Carrier', 'Hip Seat Carrier', 'Mei Tai Carrier'],
  descriptions: ['Lightweight and adjustable', 'Ergonomic and supportive', 'Soft and comfortable', 'Hands-free convenience', 'Traditional Asian-style carrier'],
  image_urls: ['baby_carrier1', 'baby_carrier2', 'baby_carrier3', 'baby_carrier4', 'baby_carrier5']
}

baby_toys_data = {
  names: ['Building Blocks', 'Shape Sorter', 'Baby Doll', 'Musical Instruments', 'Activity Cube'],
  descriptions: ['Develops problem-solving skills', 'Introduces shapes and colors', 'Encourages nurturing play', 'Fosters musical exploration', 'Engages multiple senses'],
  image_urls: ['baby_toys1', 'baby_toys2', 'baby_toys3', 'baby_toys4', 'baby_toys5']
}

users = User.all
puts "Created #{users.count} users."

# Predefined addresses for baby shops
addresses = [
  "Paris",
  "London",
  "New York",
  "Amsterdam",
  "Boston"
]

# Seed items
categories.each do |category|
  category_data = case category
                  when 'Strollers' then stroller_data
                  when 'Car Seats' then car_seat_data
                  when 'High Chairs' then high_chair_data
                  when 'Baby Carriers' then baby_carrier_data
                  when 'Baby Toys' then baby_toys_data
                  end

  category_data[:names].each_with_index do |name, i|
    item = {
      name: name,
      description: category_data[:descriptions][i],
      price: Faker::Commerce.price,
      address: addresses[i % addresses.length],
      category: category,
      user: users.sample
    }

     # Attach random photos to the item
     item_record = Item.new(item)

     image_key = category_data[:image_urls][i]
     image_url = image_urls[image_key]

     if image_url.nil?
       puts "Missing URL for key: #{image_key}"
     else
       puts "Creating item: #{name} in category #{category} with image URL: #{image_url}"
       file = URI.open(image_url)
       item_record.photos.attach(io: file, filename: File.basename(URI.parse(image_url).path), content_type: 'image/jpeg')
       item_record.save
     end
   end
 end

 puts "Created #{Item.count} items."
