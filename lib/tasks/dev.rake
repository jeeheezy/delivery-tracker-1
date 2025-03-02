desc "Hydrate the database with some sample data to look at so that developing is easier"
task({ :sample_data => :environment}) do
  User.destroy_all
  Delivery.destroy_all

  usernames = ["alice", "bob", "carol", "dave", "eve"]

  usernames.each do |username|
    user = User.new
    user.email = "#{username}@example.com"
    user.password = "password"
    user.save

    10.times do
      delivery = Delivery.new
      delivery.user_id = user.id
      delivery.description = Faker::Commerce.product_name
      delivery.details = "#{["FedEx", "UPS", "USPS"].sample} tracking ##{rand(1000000000000)}" if rand < 0.5
      delivery.supposed_arrival_date = Faker::Date.between(from: 1.month.ago, to: 2.weeks.from_now)

      if delivery.supposed_arrival_date < Time.now
        delivery.status = ["waiting", "delivered"].sample
      else
        delivery.status = "waiting"
      end

      delivery.save
    end
  end
end
