class PrivateFilesController < ApplicationController
  # GET /private_files/1
  def show
    render json: {
      id: params[:id],
      request_headers: {
        authorization: request.headers['Authorization'],
        x_authorization: request.headers['X-Authorization'],
        x_user: request.headers['X-User']
      }
    }
  end
end
