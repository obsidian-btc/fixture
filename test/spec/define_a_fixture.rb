require_relative 'spec_init'

define_a_fixture = Fixture.define do
  def self.example
    new
  end
end

describe 'Define a fixture' do
  specify 'Creates a module' do
    assert(define_a_fixture.is_a? Module)
  end
end
