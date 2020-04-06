class Api::V1::AccountsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show

    render json: { balance: 0 }
  end

  def create
    acc_params = account_params
    custom_id = acc_params[:id]
    account_name = acc_params[:name]
    account_balance = acc_params[:balance].to_i

    if !custom_id.nil?
      custom_id = acc_params[:id].to_i
      # api_message(:error, 'ID deve ser um número') and return if custom_id == 0
      return render json: { error: 'ID deve ser um número.' } if custom_id == 0

      account = Account.where(custom_id: custom_id).first
      return render json: { customer: 'ID já está em uso, por favor escolha outro.' } unless account.nil?
    end

    custom_id = custom_id || account
    create_account(custom_id, account_name, account_balance)
  end

  def transfer
    render json: { transfer: 0 }
  end


  private
  def api_message(type = :msg, msg)
    # render json: { type: msg }
    render json: { customer: 'ID já está em uso, por favor escolha outro.' }
    # exit
  end

  def create_account(custom_id = nil, account_name, account_balance)
    customer = Customer.new
    customer.name = account_name
binding.pry
    unless customer.save!
      return render json: { error: 'erro ao criar cliente' }
    end

    account = Account.new
    account.id = account_id unless account_id.nil?
    account.name = customer
    account.balance = account_balance

    unless account.save!
      return render json: { id: customer.id }
    else
      return render json: { error: 'erro ao criar conta' }
    end
  end

  def account_params
    params.permit(:id, :name, :balance)
  end
end
