#rake dev:demo

namespace :dev do

  task :demo => :environment do
    puts "demo!!"

    puts Event.count
end
#rake dev:fake
  task :fake => :environment do
    User.delete_all
    Event.delete_all
    Attendee.delete_all

    puts "Creating fake data"
    user = User.create!( :email => "tim7012@msn.com", :password => "123456")

    20.times do |i|
      e = Event.create(:name => Faker::App.name)
      20.times do |j|
        e.attendees.create( :name => Faker::Name.name)
      end
    end
  end
end