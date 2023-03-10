# frozen_string_literal: true

module PostsHelper
  def premium_label(value)
    case value
    when true
      text = 'premium'
      badge_color = 'badge bg-danger'
    when false
      text = 'free'
      badge_color = 'badge bg-success'
    end
    content_tag(:span, text, class: badge_color)
  end
end
