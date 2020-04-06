class Api::V1::AccountsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    account_id = balance_params[:id]
    account = Account.where(account_id: account_id).first
    render json: account.nil? ? { error: 'Informar um ID de conta válido para consulta.' } : { account: account.balance }
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
    transfer = transfer_params
    @amount = transfer[:amount].to_i

    return render json: { error: 'Informar valor a ser transferido.' } if @amount <= 0

    @origin_account = Account.where(account_id: transfer[:source]).first
    return render json: { error: 'Conta de origem inválida.' } if @origin_account.nil?

    @target_account = Account.where(account_id: transfer[:destination]).first
    return render json: { error: 'Conta de destino inválida.' } if @target_account.nil?

    return render json: { error: 'Saldo insuficiente.' } if @origin_account.balance < @amount

    execute_transfer

    render json: { message: 'Transação efetuada.' }
  end


  private
  def execute_transfer
    @origin_account.balance -= @amount
    @target_account.balance += @amount

    Account.transaction do
      @origin_account.save!
      @target_account.save!
    end
  end

  def api_message(msg, type = :msg)
    render json: { type: msg }
    # render json: { customer: 'ID já está em uso, por favor escolha outro.' }
    # exit
  end

  def create_account(account_name, account_balance, account_id = nil)
    customer = Customer.new
    customer.name = account_name

    unless customer.save!
      return render json: { error: 'erro ao criar cliente' }
    end

    @account = Account.new
    @account.account_id = account_id.to_i.to_s unless account_id.nil?
    @account.customer_id = customer.id
    @account.balance = account_balance

    if @account.save!
      set_account_id if account_id.nil?
      return render json: { id: @account.account_id, token: customer.access_token }
    else
      return render json: { error: 'erro ao criar conta' }
    end
  end

  def set_account_id
    @account.account_id = @account.id.to_s + 'x'
    @account.save
  end

  def account_params
    params.permit(:id, :name, :balance)
  end

  def balance_params
    params.permit(:id)
  end

  def transfer_params
    params.permit(:source, :destination, :amount)
  end
end
