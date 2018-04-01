# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Transaction.destroy_all

INFLOWS = (0..100)
OUTFLOWS = (0..100)
PAYEE = ["Adam", "Mariah", "Evan"]
DATE = ['2018-04-01', '2018-04-02', '2018-04-03']
NOTES = ["This was a great purchase", "This was a bad purchase", "This was an ok purchase"]


10.times do |num|
  Transaction.create!(date: DATE.sample, payee: PAYEE.sample, notes: NOTES.sample, inflow: rand(100))
  puts "Positive transaction #{num} created"
end

10.times do |num|
  Transaction.create!(date: DATE.sample, payee: PAYEE.sample, notes: NOTES.sample, outflow: rand(100))
  puts "Negative transaction #{num} created"
end
