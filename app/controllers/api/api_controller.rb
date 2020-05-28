module Api
  class ApiController < ApplicationController
    rescue_from StandardError, with: :render_error

    def render_error(error)
      render json: { error: error.message }, status: :bad_request
    end
  end
end
