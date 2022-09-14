# frozen_string_literal: true

require_relative "test_helper"

class DummyController < Rulers::Controller
  def dummy_action
    "expected text"
  end
end

class HomeController < Rulers::Controller
  def index
    "in HomeController#index"
  end
end

class RulersAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Class.new(Rulers::Application).new
  end

  def test_request_root_redirects_to_existing_controller_action
    get "/"

    assert last_response.ok?
    body = last_response.body
    assert body["in HomeController#index"]
  end

  def test_request_dummy
    get "/dummy/dummy_action"

    assert last_response.ok?
    body = last_response.body
    assert body["expected text"]
  end

  def test_request_not_found
    get "/missing/action"

    assert last_response.not_found?
  end

  def test_request_favicon
    get "/favicon.ico"

    assert last_response.not_found?
  end
end
