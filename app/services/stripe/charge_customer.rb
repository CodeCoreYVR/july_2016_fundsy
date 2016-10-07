class Stripe::ChargeCustomer < Service::Base
  attribute :amount, Integer
  attribute :stripe_customer_id, String
  attribute :description, String

  attribute :stripe_charge

  def call
    begin
      @stripe_charge ||= Stripe::Charge.create(
        amount: amount,
        currency: "cad",
        customer: stripe_customer_id,
        description: description # "Payment for pledge id #{pledge.id}"
      )
    rescue => e
      false
    end
  end


end
