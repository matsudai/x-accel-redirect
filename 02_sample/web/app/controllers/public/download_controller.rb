class Public::DownloadController < ApplicationController
  def index
    # Proxy URI
    response.headers['X-Accel-Redirect'] = "/internal/download?s=#{params[:s]}"

    # redirect_to "/storage/download?s=#{params[:s]}"
    redirect_to "/"
  end
end
