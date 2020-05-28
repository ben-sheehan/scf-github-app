module GitHubService
  module Events
    class Index
      attr_reader :owner, :repo, :event_type
      attr_accessor :response

      def self.call(**args)
        new(args).call
      end

      private_class_method :new

      def initialize(owner:, repo:, event_type:)
        @owner = owner
        @repo = repo
        @event_type = event_type
      end

      def call
        self.response = GitHubClient.get_events(opts)
        raise_error if response[:events].nil?
        response
      end

      private
      def opts
        {
          owner: owner,
          repo: repo,
          event_type: event_type
        }
      end

      def raise_error
        raise StandardError, response[:error]
      end
    end
  end
end
