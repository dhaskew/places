# Test factories
# from https://github.com/thoughtbot/factory_girl/wiki/Testing-all-Factories-%28with-RSpec%29
require 'rails_helper'

FactoryGirl.factories.map(&:name).each do |factory_name|
  describe "Factory :#{factory_name}" do
    it 'is valid' do
      factory = FactoryGirl.build(factory_name)
      if factory.respond_to?(:valid?)
        expect(factory).to be_valid, lambda { factory.errors.full_messages.join(',') }
      end
    end
  end

  describe "Factory :#{factory_name} with trait" do
    FactoryGirl.factories[factory_name].definition.defined_traits.map(&:name).each do |trait_name|
      it ":#{trait_name} is valid" do
        factory = FactoryGirl.build(factory_name, trait_name)
        if factory.respond_to?(:valid?)
          expect(factory).to be_valid, lambda { factory.errors.full_messages.join(',') }
        end
      end
    end
  end
end
