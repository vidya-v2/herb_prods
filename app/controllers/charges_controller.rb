class ChargesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :amount_to_be_charged
  before_action :set_description

  def new
  end

  def create
    customer = StripeTool.create_customer(email: params[:stripeEmail], 
                                          stripe_token: params[:stripeToken])

    charge = StripeTool.create_charge(customer_id: customer.id, 
                                      amount: params[:amount],
                                      description: @description)

    redirect_to thanks_path(amount: params[:amount])
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def thanks
  end

  private

    def amount_to_be_charged
      #@amount = 500
    end

    def set_description
      @description = "Some amazing product"
    end

end
