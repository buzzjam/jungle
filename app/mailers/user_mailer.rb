class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.ca'
 
  def order_email (order, line_items)
    @order = order
    @line_items  = line_items
    mail(to: @order.email, subject: "Order #{@order.id} placed!")
  end
end
