module GitHubClient
  extend self

  BASE_URL = 'https://api.github.com/repos/'

  def get_events(owner:, repo:)
    response = HTTParty.get("#{BASE_URL}#{owner}/#{repo}/events")
    parsed_response = JSON.parse(response.body)
    if parsed_response.is_a?(Array)
      { events: parsed_response.map(&:with_indifferent_access) }
    else
      { error: parsed_response['message'] }
    end
  end
end