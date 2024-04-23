require 'swagger_helper'

RSpec.describe 'api/v1/comments', type: :request do
  include AuthHelper

  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }
  let(:new_post) { create(:post, user:) }
  let(:valid_attributes) { { text: 'This is a test comment' } }

  describe 'POST /create' do
    before do
      post "/api/v1/posts/#{new_post.id}/comments", params: { comment: valid_attributes }, headers:
    end

    it 'creates a new comment' do
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json['text']).to eq(valid_attributes[:text])
      expect(json['user_id']).to eq(user.id)
      expect(json['post_id']).to eq(new_post.id)
    end
  end

  describe 'DELETE /destroy' do
    let!(:comment) { create(:comment, user:, post: new_post) }

    before do
      delete "/api/v1/posts/#{new_post.id}/comments/#{comment.id}", headers:
    end

    it 'deletes the comment' do
      expect(response).to have_http_status(:no_content)
      expect { Comment.find(comment.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
