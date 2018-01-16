class ClusterMethodsController < ApplicationController
  before_action :set_cluster_method, only: [:show, :edit, :update, :destroy]

  # GET /cluster_methods
  # GET /cluster_methods.json
  def index
    @cluster_methods = ClusterMethod.all
  end

  # GET /cluster_methods/1
  # GET /cluster_methods/1.json
  def show
  end

  # GET /cluster_methods/new
  def new
    @cluster_method = ClusterMethod.new
  end

  # GET /cluster_methods/1/edit
  def edit
  end

  # POST /cluster_methods
  # POST /cluster_methods.json
  def create
    @cluster_method = ClusterMethod.new(cluster_method_params)

    respond_to do |format|
      if @cluster_method.save
        format.html { redirect_to @cluster_method, notice: 'Cluster method was successfully created.' }
        format.json { render :show, status: :created, location: @cluster_method }
      else
        format.html { render :new }
        format.json { render json: @cluster_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cluster_methods/1
  # PATCH/PUT /cluster_methods/1.json
  def update
    respond_to do |format|
      if @cluster_method.update(cluster_method_params)
        format.html { redirect_to @cluster_method, notice: 'Cluster method was successfully updated.' }
        format.json { render :show, status: :ok, location: @cluster_method }
      else
        format.html { render :edit }
        format.json { render json: @cluster_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cluster_methods/1
  # DELETE /cluster_methods/1.json
  def destroy
    @cluster_method.destroy
    respond_to do |format|
      format.html { redirect_to cluster_methods_url, notice: 'Cluster method was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cluster_method
      @cluster_method = ClusterMethod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cluster_method_params
#      params.fetch(:cluster_method, {})
      params.fetch(:cluster_method).permit(:name, :label, :description, :attrs_json, :program, :link, :speed_id, :warning)
    end
end
