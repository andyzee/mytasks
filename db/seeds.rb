# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

seed_file = Rails.root.join('db', 'seeds.yml')
config = YAML::load_file(seed_file)
projects = config['projects'] || []
projects = projects.map{|p| {title: p['title'], todos_attributes: p['todos']} }
Project.create(projects)

# projects.each do |p|
#   project = Project.create(title: p['title'])
#   todos = p['todos'] || []
#   todos.each do |t|
#     Todo.create(text: t['text'], isCompleted: t['isCompleted'], project: project)
#   end
# end