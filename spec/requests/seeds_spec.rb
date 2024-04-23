require 'rails_helper'

RSpec.describe "Seeds", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/seeds/create"
      expect(response).to have_http_status(:success)
    end
  end

end
