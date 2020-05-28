module GitHubService
  module Events
    class Index
      attr_reader :owner, :repo
      attr_accessor :response

      def self.call(**args)
        new(args).call
      end

      private_class_method :new

      def initialize(owner:, repo:)
        @owner = owner
        @repo = repo
      end

      def call
        self.response = GitHubClient.get_events(owner: owner, repo: repo)
        raise_error if response[:events].nil?
        build_json
      end

      private
      def raise_error
        raise StandardError, response[:error]
      end

      def build_json
        {
          events: response[:events].map do |event|
            {
              actor: event[:actor],
              type: event[:type],
              created_at: event[:created_at]
            }
          end
        }
      end
    end
  end
end
