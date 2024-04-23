class SeedsController < ApplicationController
  def create
    Rails.application.load_seed
    head :ok
  end
end
