require 'swagger_helper'

RSpec.describe 'api/v1/user', type: :request do
  include AuthHelper

  let(:new_user) { create(:user) }
  let(:headers) { auth_headers(new_user) }

  describe 'GET /' do
    before do
      get "/api/v1/users/#{new_user.id}", headers:
    end

    it 'returns the user profile data' do
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['email']).to eq(new_user.email)
      expect(json['id']).to eq(new_user.id)
      expect(json['name']).to eq(new_user.name)
      expect(json['admin']).to eq(new_user.admin)

      if new_user.image.attached?
        expect(json['image']['url']).to eq(url_for(new_user.image))
      else
        expect(json['image']['url']).to be_nil
      end
      expect(json['created_month_year']).to eq(new_user.created_at.strftime('%B %Y'))
    end
  end
end
