# frozen_string_literal: true

require_relative "test_helper"

class RulersAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Class.new(Rulers::Application).new
  end

  def test_request_root
    get "/"

    assert last_response.ok?
    body = last_response.body
    assert body["Hello"]
  end

  def test_request_not_found
    skip
    get "/missing"

    assert last_response.not_found?
  end
end
