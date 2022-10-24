class ExternalFilesController < ApplicationController
  # GET /external_files?p=/path/to/file
  def index
    fpath = params[:p]

    if fpath === '/aaa/bbb/ccc.txt'
      headers['X-Original-File-Path'] = fpath
      headers['X-Accel-Redirect'] = '/_files'
      redirect_to 'http://web:3000/internal_files?p=/ddd/eee/fff.txt', allow_other_host: true
    else
      render json: { status: 404 }, status: 404
    end
  end
end
