class Api::V1::AccountsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show

    render json: { balance: 0 }
  end

  def create

    render json: { customer: 'created' }
  end

  def transfer
    render json: { transfer: 0 }
  end
end
