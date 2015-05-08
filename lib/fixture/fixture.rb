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
end
