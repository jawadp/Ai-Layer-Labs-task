require 'swagger_helper'

RSpec.describe 'api/v1/likes', type: :request do
  include AuthHelper

  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }
  let(:new_post) { create(:post, user:) }

  describe 'POST /create' do
    context 'when user is authenticated' do
      before do
        post "/api/v1/posts/#{new_post.id}/likes", headers:
      end

      it 'creates a new like' do
        expect(response).to have_http_status(:created)
        expect(Like.count).to eq(1)
        expect(Like.last.user).to eq(user)
        expect(Like.last.post).to eq(new_post)
      end
    end

    context 'when user is not authenticated' do
      before do
        post "/api/v1/posts/#{new_post.id}/likes"
      end

      it 'returns unauthorized' do
        expect(response).to have_http_status(:unauthorized)
        expect(Like.count).to eq(0)
      end
    end
  end
end
