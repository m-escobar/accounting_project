class Api::V1::AccountsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    account_id = balance_params[:id].to_i
    unless account_id > 0
      return render json: { error: 'Informar um ID de conta válido para consulta.' }
    else
      account = Account.where(custom_id: account_id).first
      render json: { account: account.balance }
    end
  end

  def create
    acc_params = account_params
    custom_id = acc_params[:id]
    account_name = acc_params[:name]
    account_balance = acc_params[:balance].to_i

    if !custom_id.nil?
      custom_id = acc_params[:id]
      return render json: { error: 'ID deve ser um número.' } if custom_id == 0

      account = Account.where(account_id: custom_id).first
      return render json: { customer: 'ID já está em uso, por favor escolha outro.' } unless account.nil?
    end

    create_account(account_name, account_balance, custom_id)
  end

  def transfer
    render json: { transfer: 0 }
  end


  private
  def api_message(msg, type = :msg)
    render json: { type: msg }
    # render json: { customer: 'ID já está em uso, por favor escolha outro.' }
    # exit
  end

  def create_account(account_name, account_balance, account_id = nil)
    customer = Customer.new
    customer.name = account_name
binding.pry
    unless customer.save!
      return render json: { error: 'erro ao criar cliente' }
    end

    @account = Account.new
    @account.account_id = account_id.to_i.to_s unless account_id.nil?
    @account.customer_id = customer.id
    @account.balance = account_balance

    if @account.save!
      set_account_id if account_id.nil?
      return render json: { id: @account.account_id, token: 'tok' }
    else
      return render json: { error: 'erro ao criar conta' }
    end
  end

  def set_account_id
    @account.account_id = @account.id += 'x'
    @account.save
  end

  def account_params
    params.permit(:id, :name, :balance)
  end

  def balance_params
    params.permit(:id)
  end
end
