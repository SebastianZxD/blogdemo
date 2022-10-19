# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts 'Seeding the development database...'
bugget = User.first_or_create!(email: 'admin@test.com',
                              password: '123456',
                              password_confirmation: '123456',
                              first_name: 'Bugget',
                              last_name: 'Zambrano',
                              role: User.roles[:admin])

flaco = User.first_or_create!(email: 'user@test.com',
				            password: '123456',
				            password_confirmation: '123456',
				            first_name: 'Flaco',
                            last_name: 'Quintero',
				            role: User.roles[:user])

Address.first_or_create!(street: 'Dg 47A',
				         city: 'Medallo',
				         state: 'ANT',
				         zip: '	050022',
                         country: 'COL',
			             user: bugget)

Address.first_or_create!(street: 'K54 #23A',
				         city: 'Malambo',
				         state: 'QMI',
				         zip: '	077089',
                         country: 'COL',
			             user: flaco)
		


elapsed = Benchmark.measure do
  posts = []
  10.times do |x|
    puts "Creating Post #{x}"
    post = Post.new(title: "Title #{x}",
                    body: "Body #{x} Demasiados pelos en la cac",
                    user: bugget)


    3.times do |y|
      puts "Creating Comment #{y} for post #{x}"
      post.comments.build(body: "Im commenting haha im #{y}",
                          user: flaco)
    end
    posts.push(post)
  end
  Post.import(posts, recursive: true)
end


puts "Seeded development DB in  #{elapsed.real} seconds"
