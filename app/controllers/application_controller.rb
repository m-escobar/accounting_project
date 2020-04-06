class ApplicationController < ActionController::Base

  def authorize
    if valid_customer && (valid_customer.ensure_token?(@header_access_token))
      return true
    else
      authorization_denied
    end
  end

  def valid_customer
    @header_access_token ||= request.headers['X-Client-Access-Token']
    raise InvalidTokenException if @header_access_token.blank? && @customer.blank?
    @customer ||= Customer.find_by!(access_token: @header_access_token)
  end

protected
  def authorization_denied
    render json: { error: 'Acesso negado' }, status: :forbidden and return
  end

end
