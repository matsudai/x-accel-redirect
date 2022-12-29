class Storage::DownloadController < ApplicationController
  def index
    size = case params[:s]
    when '1k'
      1
    when '10k'
      10
    when '20k'
      20
    when '1m'
      1_000
    when 'timeout'
      sleep 10
      1
    end

    if size
      buffer = size.times.map { SecureRandom.alphanumeric(1_000 - 1) }.join("\n") + "\n"
      response.headers['Content-Length'] = buffer.bytesize
      send_data buffer, status: 200, filename: 'data.txt', type: ' text/plain', disposition: 'attachment'
    else
      render status: 404
    end
  end
end
