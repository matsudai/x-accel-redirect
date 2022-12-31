class Private::UploadController < ApplicationController
  def create
    puts "============================ #{request.raw_post.size} ============================"
    render status: 201, json: params
  end
end
