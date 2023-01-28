#Stripe.api_key = 'sk_test_51MTOo7Gd3fCFXdgIPfKEahejs8ZXli5HPU2WFEc8l6kHVSv8a0jmrZdMABd2sltH0hcLDXn2Eg7Mxzm6gO6aOeCv00Cs5Drh8h'
Stripe.api_key = Rails.application.credentials.dig(Rails.env.to_sym, :stripe, :secret)

# developmet:
#     Stripe:
#         secret: