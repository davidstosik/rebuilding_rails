# frozen_string_literal: true

class Object
  def self.const_missing(const_name)
    require const_name.to_s.underscore
    Object.const_get(const_name)
  rescue LoadError
    puts "Failed to load #{const_name}"
    super
  end
end
