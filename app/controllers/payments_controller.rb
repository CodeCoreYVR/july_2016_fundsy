class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @pledge = Pledge.find params[:pledge_id]
  end

  def create
    pledge = Pledge.find params[:pledge_id]

    stripe_customer = Stripe::Customer.create(
      description: "Customer for #{current_user.email}",
      source: params[:stripe_token] # single use token from Stripe.js
    )
    current_user.stripe_customer_id = stripe_customer.id
    current_user.save

    # to charge without creating customers:
    # stripe_charge = Stripe::Charge.create(
    #   amount: (pledge.amount * 100).to_i,
    #   currency: "cad",
    #   source: params[:stripe_token],
    #   description: "Payment for pledge id #{pledge.id}"
    # )

    stripe_charge = Stripe::Charge.create(
      amount: (pledge.amount * 100).to_i,
      currency: "cad",
      customer: stripe_customer.id,
      description: "Payment for pledge id #{pledge.id}"
    )
    pledge.stripe_txn_id = stripe_charge.id
    pledge.save

    redirect_to campaign_path(pledge.campaign), notice: "Payment completed!"
  end
end
