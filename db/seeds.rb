# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Bowl.create(name: "Downtime", description: "Things to do when I have a minute")
Bowl.create(name: "Exercise", description: "Break a sweat")
Bowl.create(name: "Crafts", description: "Making stuff")

Scrap.create(description: "Guitar", category: "music")
Scrap.create(description: "Skateboard", category: "exercise")
Scrap.create(description: "Drawing", category: "art")
