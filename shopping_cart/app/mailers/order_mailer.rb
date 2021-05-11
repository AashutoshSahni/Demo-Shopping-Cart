class OrderMailer < ApplicationMailer
  default from: 'asahni@deqode.com'

  def order_delivered(email, name)
    @name = name
    mail(to: email, subject: "Welcome to my awesome site")
  end
end
