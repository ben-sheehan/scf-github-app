require 'rails_helper'

RSpec.describe 'GitHub::Events endpoints', type: :request do
  describe 'GET /api/git_hub/events' do
    let(:params) do
      {
        owner: 'rails',
        repo: 'rails'
      }
    end

    subject do
      VCR.use_cassette('api_git_hub_events_index', record: :new_episodes) do
        get '/api/git_hub/events', params: params
      end
    end

    it 'returns response status ok' do
      subject
      expect(response).to have_http_status :ok
    end

    it 'returns array of events' do
      subject
      expect(response_json['events']).to be_an Array
    end

    it 'returns events with relevant keys' do
      subject
      expect(response_json['events'].first).to match hash_including(
        'actor',
        'type',
        'created_at'
      )
    end

    context 'when repo does not exist' do
      let(:params) do
        {
          owner: 'fake_does_not_exist',
          repo: 'really_so_fake'
        }
      end

      it 'returns bad_request status' do
        subject
        expect(response).to have_http_status :bad_request
      end

      it 'returns error message' do
        subject
        expect(response_json['error']).to eq 'Not Found'
      end
    end
  end
end
