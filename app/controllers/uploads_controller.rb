class UploadsController < ApplicationController
  before_action :set_upload, only: [:show, :edit, :update, :destroy, :upload, :do_upload, :resume_upload, :update_status, :reset_upload]

  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all.order(name: :asc)
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
    # If upload is not commenced or finished, redirect to upload page
    return redirect_to upload_upload_path(@upload) if @upload.status.in?(%w(new uploading))
  end

  # GET /uploads/new
  def new
    @upload = Upload.new
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @upload = Upload.new(upload_params)
    @upload.status = 'new'

    respond_to do |format|
      if @upload.save
        format.html { redirect_to upload_upload_path(@upload), notice: 'Upload was successfully created.' }
        format.json { render :show, status: :created, location: @upload }
      else
        format.html { render :new }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update
    @upload.assign_attributes(status: 'new', upload: nil) if params[:delete_upload] == 'yes'

    respond_to do |format|
      if @upload.update(upload_params)
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { render :show, status: :ok, location: @upload }
      else
        format.html { render :edit }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to uploads_url, notice: 'Upload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /uploads/:id/upload
  def upload

  end

  # PATCH /uploads/:id/upload.json
  def do_upload
    unpersisted_upload = Upload.new(uploado_params)
    logger.debug("UPLOAD: " + @upload.to_json + ", " + @upload.id.to_s)
    tmp_dir = Pathname.new(APP_CONFIG[:user_data_dir]) + "uploads"
#     logger.debug("upload_path: " + @upload.upload.path)
    file_path = tmp_dir + "#{@upload.id}.txt"
    # If no file has been uploaded or the uploaded file has a different filename,
    # do a new upload from scratch
    if @upload.upload_file_name != unpersisted_upload.upload_file_name
      @upload.assign_attributes(upload_params)
      @upload.status = 'uploading'
      @upload.save!
      render json: @upload.to_jq_upload and return

    # If the already uploaded file has the same filename, try to resume
    else
      current_size = @upload.upload_file_size
      content_range = request.headers['CONTENT-RANGE']
      begin_of_chunk = content_range[/\ (.*?)-/,1].to_i # "bytes 100-999999/1973660678" will return '100'

      # If the there is a mismatch between the size of the incomplete upload and the content-range in the
      # headers, then it's the wrong chunk! 
      # In this case, start the upload from scratch
      unless begin_of_chunk == current_size
        @upload.update!(upload_params)
        render json: @upload.to_jq_upload and return
      end
      
      # Add the following chunk to the incomplete upload
      #    logger.debug("upload_path: " + @upload.upload.path)
      logger.debug('WRITE FILE')
      File.open(file_path, "ab") { |f| f.write(upload_params[:upload].read) }

      # Update the upload_file_size attribute
      @upload.upload_file_size = @upload.upload_file_size.nil? ? unpersisted_upload.upload_file_size : @upload.upload_file_size + unpersisted_upload.upload_file_size
      @upload.save!

      render json: @upload.to_jq_upload and return
    end
  end

  # GET /uploads/:id/reset_upload
  def reset_upload
    # Allow users to delete uploads only if they are incomplete
    raise StandardError, "Action not allowed" unless @upload.status == 'uploading'
    @upload.update!(status: 'new', upload: nil)
    redirect_to @upload, notice: "Upload reset successfully. You can now start over"
  end

  # GET /uploads/:id/resume_upload.json
  def resume_upload
    render json: { file: { name: @upload.upload.url(:default, timestamp: false), size: @upload.upload_file_size } } and return
  end

  # PATCH /uploads/:id/update_upload_status
  def update_status
    raise ArgumentError, "Wrong status provided " + params[:status] unless @upload.status == 'uploading' && params[:status] == 'uploaded'
    @upload.update!(status: params[:status])
    head :ok
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_upload
    @upload = Upload.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def upload_params
    params.require(:upload).permit(:name)
  end

  def uploado_params
    params.require(:upload).permit(:upload)
  end
end
