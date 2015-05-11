require_relative 'spec_init'

define_a_fixture_class = Fixture.define(:SomeModule) do
  def self.example_class
    define_class(:SomeClass) do
    end
  end

  def self.example
    example_class.new
  end
end

describe 'Define a fixture class' do
  specify 'The created class is within the given Module namespace' do
    example = define_a_fixture_class.example

    namespace = example.class.name

    assert(namespace.include? 'SomeModule')
  end

  specify 'The created class is within the given Class namespace' do
    example = define_a_fixture_class.example

    namespace = example.class.name

    assert(namespace.include? 'SomeClass')
  end
end
