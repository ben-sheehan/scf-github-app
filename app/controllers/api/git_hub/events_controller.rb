module Api
  module GitHub
    class EventsController < ApiController
      def index
        @resources = GitHubService::Events::Index.call(**service_opts)
      end

      private
      def safe_params
        params.permit(
          :owner,
          :repo,
          :event_type
        )
      end

      def service_opts
        safe_params.to_h.deep_symbolize_keys
      end
    end
  end
end
