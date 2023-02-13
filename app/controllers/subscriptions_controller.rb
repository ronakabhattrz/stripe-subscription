class SubscriptionsController < ApplicationController
  # before_action :set_subscription, except: %i[create]

  def index
    @plans = Plan.all
    @subscription = Subscription.new if current_user.subscription.blank?
  end

  def create
    @subscription = Subscription.new(subscription_params)
    begin
      create_stripe_reference(subscription_params)
      redirect_to subscriptions_path, flash: { notice: "Subscription created successfully." }
    rescue Exception => e
      redirect_to edit_user_registration_path, flash: { alert: "Something went wrong!!"}
    end
  end

  def create_stripe_reference(subscription_params)
    @plan = Plan.find_by_id(subscription_params["plan_id"])
    Stripe::Customer.create_source(
      current_user.stripe_id,
      { source: generate_card_token(subscription_params) }
    )
    response = Stripe::Subscription.create({
                                             customer: current_user.stripe_id,
                                             items: [
                                                         { price: @plan.stripe_price_id }
                                                       ]
                                           })
    @subscription.stripe_id = response.id
    @subscription.save
  end

  def generate_card_token(subscription_params)
    Stripe::Token.create({
                           card: {
                             number: subscription_params["card_number"],
                             exp_month: subscription_params["exp_month"],
                             exp_year: subscription_params["exp_year"],
                             cvc: subscription_params["cvc"]
                           }
                         }).id
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params.require(:subscription).permit(:card_number, :exp_month, :exp_year, :cvc, :user_id, :plan_id, :active)
  end
end
