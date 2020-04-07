class Api::V1::AccountsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize, only: [:show, :transfer]

  def show
    account_id = balance_params[:account_id]
    account = Account.where(account_id: account_id).first

    if account.nil?
      api_message('Informar um ID de conta válido para consulta.')
    else
     api_message(account.balance, type = :balance)
    end
  end

  def create
    acc_params = account_params
    custom_id = acc_params[:account_id]
    account_name = acc_params[:account_name]
    account_balance = acc_params[:initial_amount].to_i

    return api_message('Informe o nome do Cliente.') if account_name.nil?

    if !custom_id.nil?
      return api_message('ID deve ser um número.') if custom_id == 0

      account = Account.where(account_id: custom_id).first
      return api_message('ID já está em uso, por favor escolha outro.')  unless account.nil?
    end

    create_account(account_name, account_balance, custom_id)
  end

  def transfer
    transfer = transfer_params
    @amount = transfer[:amount].to_i

    return api_message('Informar valor a ser transferido.') if @amount <= 0

    @origin_account = Account.where(account_id: transfer[:source_account_id]).first
    return api_message('Conta de origem inválida.') if @origin_account.nil?

    @target_account = Account.where(account_id: transfer[:destination_account_id]).first
    return api_message('Conta de destino inválida.')  if @target_account.nil?

    return api_message('Saldo insuficiente.') if @origin_account.balance < @amount
    execute_transfer

    api_message('Transação efetuada.', type = :message)
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

  def api_message(msg, type = :error)
    render json: { type => msg }
  end

  def create_account(account_name, account_balance, account_id = nil)
    customer = Customer.new
    customer.name = account_name

    unless customer.save!
      api_message('erro ao criar cliente')
    end

    @account = Account.new
    @account.account_id = account_id unless account_id.nil? #.to_i.to_s
    @account.customer_id = customer.id
    @account.balance = account_balance

    if @account.save!
      set_account_id if account_id.nil?
      return render json: { account_id: @account.account_id, token: customer.access_token }
    else
      return api_message('erro ao criar conta')
    end
  end

  def set_account_id
    @account.account_id = @account.id.to_s + 'x'
    @account.save
  end

  def account_params
    params.permit(:account_id, :account_name, :initial_amount)
  end

  def balance_params
    params.permit(:account_id)
  end

  def transfer_params
    params.permit(:source_account_id, :destination_account_id, :amount)
  end
end
