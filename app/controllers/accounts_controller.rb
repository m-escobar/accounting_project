class AccountsController < ApplicationController

  def show
    render json: { balance: 0 }
  end

  def create
    render json: { customer: created }
  end

  def transfer
    render json: { transfer: 0 }
  end
end
