# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: "Sara", email:"sara@email.com", password:"password", image:"http://www.qygjxz.com/data/out/92/4500253-girl-profile-picture.jpg")
User.create(name: "James", email:"james@email.com", password:"password", image:"https://s-media-cache-ak0.pinimg.com/736x/c8/09/02/c80902787040a7562566bd10cb4a44e0--college-hairstyles-hairstyles-for-guys.jpg")
User.create(name: "Jenny", email:"jenny@email.com", password:"password", image:"https://s-media-cache-ak0.pinimg.com/originals/82/a7/de/82a7de90c2c0febc5a9ba30041e9ca96.jpg")
User.create(name: "Steve", email:"steve@email.com", password:"password", image:"https://s-media-cache-ak0.pinimg.com/736x/1a/87/63/1a87631f83466c798ee89c6ee8b4480a--classy-hairstyles-undercut-hairstyles.jpg")

Relationship.create(user_id: 1, connection_id: 2, connected_status: "connected", step_id: 0, step_status: "green")
Relationship.create(user_id: 2, connection_id: 1, connected_status: "connected", step_id: 0, step_status: "yellow")
Relationship.create(user_id: 3, connection_id: 4, connected_status: "connected")
Relationship.create(user_id: 4, connection_id: 3, connected_status: "connected")
Relationship.create(user_id: 2, connection_id: 3, connected_status: "disconnected", step_id: 2, step_status: "red")
Relationship.create(user_id: 3, connection_id: 2, connected_status: "disconnected", step_id: 2)

Step.create(title: "Initial Meeting")
Step.create(title: "Phone Call")
Step.create(title: "Coffee")
Step.create(title: "Dinner")



