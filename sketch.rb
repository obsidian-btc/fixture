require 'securerandom'

module Fixture
  def define_fixture(name=nil, &blk)
    raise "Fixture definition requires a block" unless block_given?

    fixture_mod = Fixture::Define.get_fixture_module(name)

    fixture_mod.class_eval(&blk)

    fixture_mod
  end
  alias :define :define_fixture
  module_function :define_fixture
  module_function :define

  module Define
    def self.get_module(name, outer=Object)
      mod = nil

      if outer.const_defined?(name)
        mod = outer.const_get(name)
      else
        mod = outer.const_set(name, Module.new)
      end

      mod
    end

    def self.get_fixture_module(name)
      outer_mod = get_module('Fixture')

      random_id = SecureRandom.uuid.gsub('-', '')
      random_mod_name = "M#{RandomID.random_id}"

      random_mod = get_module(random_mod_name, outer_mod)

      if name
        fixture_mod = get_module(name, random_mod)
      else
        fixture_mod = random_mod
      end

      fixture_mod.extend DefineClass

      fixture_mod
    end

    module RandomID
      def self.random_id
        SecureRandom.uuid.gsub('-', '')
      end
    end

    module DefineClass
      def define_class(name=nil, base=nil, &blk)
        raise "Class definition requires a block" unless block_given?

        name ||= "C#{RandomID.random_id}"

        class_const = DefineClass.get_class(name, self)

        class_const.class_eval(&blk)

        class_const
      end

      def self.get_class(name, outer=Object, base=nil)
        mod = nil

        if outer.const_defined?(name)
          mod = outer.const_get(name)
        else
          cls = base.nil? ? Class.new : Class.new(base)
          mod = outer.const_set(name, cls)
        end

        mod
      end
    end
  end
end

# - - -

fixture = Fixture.define do
  def self.example_class
    define_class do
      def foo
        puts "in foo"
      end
    end
  end

  def self.example
    example_class.new
  end
end

fixture.example.foo
