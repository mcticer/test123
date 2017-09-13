namespace :db do
  desc "Fill development database with sample data"

  task populate: :environment do
    puts "[.] Gold leader, starting my attack run!"
    puts "[.] Creating admin user.."
    user = User.new(user_name: "ryan", real_name: "Ryan C. Moon", email_address: "ryan@organizedvillainy.com", password: "foobar12", password_confirmation: "foobar12")
    user.save
    user.toggle!(:admin)

    puts "[.] Creating helper user.."
    User.create!(user_name: "helper", real_name: "helper",email_address: "helper@organizedvillainy.com", password: "foobar12", password_confirmation: "foobar12")

    puts "[.] Creating test user.."
    User.create!(user_name: "tester", real_name: "Testie McGroin",email_address: "test@organizedvillainy.com", password: "foobar12", password_confirmation: "foobar12")

    puts "[.] Creating 19 test users.."
    19.times do |n|
      print "."
      user = User.create(FactoryGirl.attributes_for(:user))
    end
    puts ""

    puts "[.] Creating 20 fake analytics.."
    20.times do |n|
      print "."
      analytic = Analytic.create(FactoryGirl.attributes_for(:analytic))
    end
    puts ""


    puts "[.] Complete. Will you be my friend?"
  end
end
