module Fixture
  module Define
    module RandomID
      def self.random_id
        SecureRandom.uuid.gsub('-', '')
      end
    end
  end
end
