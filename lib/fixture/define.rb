module Fixture
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
  end
end
