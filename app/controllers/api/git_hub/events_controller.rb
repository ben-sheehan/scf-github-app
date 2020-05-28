module Api
  module GitHub
    class EventsController < ApiController
      def index
        resources = GitHubClient.get_events(
          owner: params[:owner], repo: params[:repo]
        )
        if resources[:events].present?
          render json: resources, status: :ok
        else
          render json: resources, status: :not_found
        end
      end
    end
  end
end
