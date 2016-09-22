module Helpers
  def say_hello(name)
    puts "Hello #{name}"
  end
end

class MyClass1
  include Helpers
end

class MyClass2
  extend Helpers
end

MyClass1.new.say_hello("Tam")
MyClass2.say_hello("Tam")
