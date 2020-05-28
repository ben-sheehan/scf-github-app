require 'rails_helper'

RSpec.describe GitHubClient do
  describe '::get_events' do
    subject do
      VCR.use_cassette('git_hub_client_get_events') do
        GitHubClient.get_events(
          owner: 'rails',
          repo: 'rails',
          event_type: 'IssueCommentEvent'
        )
      end
    end

    it 'returns array of events for specified repo' do
      expect(subject[:events]).to be_an Array
    end

    it 'returns array of objects with actor, event type and timestamp' do
      expect(subject[:events].first).to match hash_including(
        :actor,
        :type,
        :created_at
      )
    end

    context 'when repo does not exist' do
      subject do
        VCR.use_cassette('git_hub_client_get_events_fail') do
          GitHubClient.get_events(
            owner: 'soo_soo_fake',
            repo: 'very_fake',
            event_type: 'IssueCommentEvent'
          )
        end
      end

      it 'returns error message' do
        expect(subject[:error]).to be_present
      end
    end
  end
end