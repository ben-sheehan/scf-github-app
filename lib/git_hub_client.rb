module GitHubClient
  extend self

  BASE_URL = 'https://api.github.com/repos/'

  def get_events(owner:, repo:)
    response = HTTParty.get("#{BASE_URL}#{owner}/#{repo}/events")
    parsed_response = JSON.parse(response.body)
    if parsed_response.is_a?(Array)
      { events: build_events(response) }
    else
      { error: parsed_response['message'] }
    end
  end

  private
  def build_events(response)
    response.map do |event|
      Hashie::Mash.new(
        type: event['type'],
        actor: event['actor']['display_login'],
        created_at: Time.new(event['created_at']).strftime('%A, %b %d')
      )
    end
  end
end