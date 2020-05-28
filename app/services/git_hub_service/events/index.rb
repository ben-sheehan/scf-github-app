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
        response
      end

      private
      def raise_error
        raise StandardError, response[:error]
      end
    end
  end
end
