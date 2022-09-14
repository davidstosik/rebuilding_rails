# frozen_string_literal: true

require_relative "test_helper"

class DependenciesTest < Minitest::Test
  def test_autoloading_loads_file_corresponding_to_constant
    Dir.mktmpdir do |tmpdir|
      file_path = File.join(tmpdir, "dummy_class.rb")
      File.open(file_path, "wb") do |file|
        file << <<~CONTENT
          class DummyClass
            def self.dummy_method
              "expected output"
            end
          end
        CONTENT
      end

      $LOAD_PATH << tmpdir

      assert_equal "expected output", DummyClass.dummy_method

      $LOAD_PATH.delete(tmpdir)
      Object.send(:remove_const, :DummyClass)
    end
  end

  def test_autoloading_raises_name_error_when_file_not_found
    assert_raises(NameError) { DummyClass }
  end
end
