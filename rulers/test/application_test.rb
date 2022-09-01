# frozen_string_literal: true

require_relative "test_helper"

class DummyController < Rulers::Controller
  def dummy_action
    "expected text"
  end
end

class RulersAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Class.new(Rulers::Application).new
  end

  def test_request_root
    skip
    get "/"

    assert last_response.ok?
    body = last_response.body
    assert body["Hello"]
  end

  def test_request_dummy
    get "/dummy/dummy_action"

    assert last_response.ok?
    body = last_response.body
    assert body["expected text"]
  end

  def test_request_not_found
    skip
    get "/missing"

    assert last_response.not_found?
  end
end
