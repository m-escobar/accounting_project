class ApplicationController < ActionController::Base

  def authorize
    if valid_customer?
      return true
    else
      authorization_denied
    end
  end

private
  def valid_customer?
    @access_token = request.headers['X-Client-Access-Token']
    customer = Customer.where(access_token: @access_token).empty? ? false : true
    customer
  end

protected
  def authorization_denied
    render json: { Erro: 'Acesso negado' }, status: :forbidden and return
  end

end
