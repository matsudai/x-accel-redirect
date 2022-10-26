class AuthVerifyController < ApplicationController
  # GET /auth_verify
  #
  # < Authorization:   <Authorization header>
  # > X-Authorization: <Authorization header> (pass through)
  # > X-User:          <User ID>              (Verify OK)
  #
  def index
    authorization_token = request.headers['Authorization']
    use_id = authorization_token ? "user-#{authorization_token}" : nil

    response.headers['X-Authorization'] = authorization_token
    response.headers['X-User'] = use_id

    render json: {
      request_headers: {
        authorization: authorization_token
      },
      response_headers: {
        x_authorization: authorization_token,
        x_user: use_id
      }
    }
  end
end
