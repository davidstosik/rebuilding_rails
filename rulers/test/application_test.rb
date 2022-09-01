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

  def test_request_root_without_indexhtml
    refute File.exist?("public/index.html")

    get "/"

    assert last_response.not_found?
  end

  def test_request_root_with_indexhtml
    File.stub(:exist?, true) do
      File.stub(:read, "expected content") do
        get "/"

        assert last_response.ok?
        assert last_response.body["expected content"]
      end
    end
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
