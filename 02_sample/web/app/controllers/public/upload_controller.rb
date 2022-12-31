class Public::UploadController < ApplicationController
  def create
    puts "============================ #{request.raw_post.size} ============================"
    response.headers['X-Storage-Uri'] = '/internal/upload'
    render status: 200
  end
end
