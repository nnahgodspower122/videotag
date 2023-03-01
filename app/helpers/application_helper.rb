# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def active_link_to(name, path)
    content_tag(:li, class: "#{'active fw-bold' if current_page?(path)} nav-item") do
      link_to name, path, class: 'nav-link'
    end
  end

  def deep_active_link_to(path, &block)
    content_tag(:li, class: "#{'active fw-bold' if current_page?(path)} nav-item") do
      link_to path, class: 'nav-link', &block
    end
  end

  def deep_active_link_to_dropdown_item(path, &block)
    content_tag(:li) do
      link_to path, class: "#{'active fw-bold' if current_page?(path)} dropdown-item", &block
    end
  end

  def boolean_label(value)
    case value
    when true
      badge_color = 'badge bg-success'
    when false
      badge_color = 'badge bg-danger'
    end
    content_tag(:span, value, class: badge_color)
  end

  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'

  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  def markdown(text)
    return '' if text.nil?

    options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: { rel: 'nofollow', target: '_blank' },
      prettify: true
    }

    extensions = {
      autolink: true,
      tables: true,
      fenced_code_blocks: true,
      lax_spacing: true,
      no_intra_emphasis: true,
      strikethrough: true,
      superscript: true,
      disable_indented_code_blocks: true
    }

    # Redcarpet::Markdown.new(HTML.new(options), extensions).render(text).html_safe
    # these 3 lines do same as above 1 line
    renderer = HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text).html_safe
  end
end
