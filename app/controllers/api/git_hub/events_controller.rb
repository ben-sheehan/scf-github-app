module Api
  module GitHub
    class EventsController < ApiController
      def index
        resources = GitHubService::Events::Index.call(**service_opts)
        render json: resources, status: :ok
      end

      private
      def safe_params
        params.permit(
          :owner,
          :repo
        )
      end

      def service_opts
        safe_params.to_h.deep_symbolize_keys
      end
    end
  end
end
