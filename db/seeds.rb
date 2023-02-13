# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Plan.create(
  name: 'Starter',
  description: 'This subscription will be charged every month',
  interval: 'month',
  price_cents: 500
)

Plan.create(
  name: 'Delux',
  description: 'This subscription will be charged every month',
  interval: 'month',
  price_cents: 1500
)

Plan.create(
  name: 'Professional',
  description: 'This subscription will be charged every month',
  interval: 'month',
  price_cents: 2500
)