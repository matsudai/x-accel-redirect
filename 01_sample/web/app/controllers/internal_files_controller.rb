class InternalFilesController < ApplicationController
  # GET /internal_files?p=/path/to/file
  def index
    render json: {
      status: 200,
      x_original_file_path: request.headers['X-Original-File-Path'],
      file_path: params[:p]
    }
  end
end
