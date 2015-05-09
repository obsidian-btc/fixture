# Fixtures

Use fixtures in testing environment to reduce errors and create consistent and repeatable tests.

## Example Without Explicit Naming
````
fixture = Fixture.define do
  def self.example_class
    define_class do
      def foo
        "bar"
      end
    end
  end

  def self.example
    example_class.new
  end
end

some_fixture = fixture.example

some_fixture.foo == "bar"
# => true
````

In the above code, `some_fixture` is an instance of a class with an outermost namespace of `Fixture`, a randomly assigned UUID as a module within Fixture, and a randomly assigned UUID as a class within the module, i.e.

````
puts fixture.example
# => <Fixture::M1bd19401d8674d54a87f7871511f0daf::C9980bf7c3cbd42df88cc9bc35b251d50:0x26f67b76>
````

This allows each set of tests to run independently of one another, but still contains all test data within the `Fixture` namespace.

## Example With Explicit Naming
````
fixture = Fixture.define(:SomeModule) do
  def self.naming_example_class
    define_class(:SomeClass) do
      def foo
        "bar"
      end
    end
  end

  def self.naming_example
    naming_example_class.new
  end
end
````

In this case, a module name `SomeModule` and a class name `SomeClass` are explicitly passed in to the Fixture.

````
puts fixture.naming_example
# => <Fixture::Mdaa0e47242934a8db244fc91363a4e0d::SomeModule::SomeClass:0x26f67b76>
````

The fixture retains the randomly assigned UUID module namespace directly beneath the `Fixture` namespace so that the test environments are still guaranteed to be independent. The `SomeModule` namespace and the `SomeClass` class name follow.

