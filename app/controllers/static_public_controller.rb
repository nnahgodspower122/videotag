# frozen_string_literal: true
class StaticPublicController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[landing_page pricing about]

  def landing_page
  end

  def pricing
    @pricing = Stripe::Price.list(lookup_keys: %w[pro_monthly pro_yearly],
                                  expand: ['data.product']).data.sort_by(&:unit_amount)
  end

  def privacy
  end

  def about
  end

  def terms
  end

  def hello 
    HelloJob.perform_at(10.seconds.from_now)
  end

end
