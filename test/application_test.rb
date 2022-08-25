# frozen_string_literal: true

require_relative "test_helper"

class RulersAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Class.new(Rulers::Application).new
  end

  def test_request
    get "/"

    assert last_response.ok?
    body = last_response.body
    assert body["Hello"]
  end
end
