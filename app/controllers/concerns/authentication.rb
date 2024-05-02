module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request
  end

  private

  def authenticate_request
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last if auth_header
    begin
      decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256')
      payload = decoded_token.first
      @current_user = User.find(payload['user_id'])
    rescue JWT::DecodeError
      render status: :unauthorized, json: { error: 'Unauthorized' }
    end
  end
end
