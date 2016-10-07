class Stripe::CreateCustomer < Service::Base
  attribute :description, String
  attribute :stripe_token, String

  attribute :stripe_customer

  def call
    begin
      @stripe_customer ||= Stripe::Customer.create(
        description: description,
        source: stripe_token
      )
    rescue Stripe::StripeError => e
      false
    rescue => e
      false
    end
  end

end
