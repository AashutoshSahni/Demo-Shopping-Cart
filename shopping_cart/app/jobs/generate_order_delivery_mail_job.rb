class GenerateOrderDeliveryMailJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    # OrderMailer.with(email: email).deliver_now!
    puts "nd qkd qjndqjndqjndq d"
  end
end
