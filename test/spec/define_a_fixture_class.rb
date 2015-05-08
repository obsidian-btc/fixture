require_relative 'spec_init'

define_a_fixture_class = Fixture.define do
  def self.example_class
    define_class do
    end
  end
end

describe 'Define a fixture class' do
  specify 'Creates a class' do
    example_class = define_a_fixture_class.example_class

    assert(example_class.is_a? Class)
  end

  specify 'The created class is within the Fixture namespace' do
    example_class = define_a_fixture_class.example_class

    assert(example_class.const_defined? :Fixture)
  end
end
