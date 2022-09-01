# frozen_string_literal: true

require "json"

class QuotesController < Rulers::Controller
  def a_quote
    "There is nothing either good or bad but thinking makes it so." +
      <<~ENV
      <pre>
      #{JSON.pretty_generate(env)}
      </pre>
      ENV
  end

  def exception
    raise "It's a bad one!"
  end
end
