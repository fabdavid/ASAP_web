class GeneSetNamesController < ApplicationController
  before_action :set_gene_set_name, only: [:show, :edit, :update, :destroy]

  # GET /gene_set_names
  # GET /gene_set_names.json
  def index
    @gene_set_names = GeneSetName.all
  end

  # GET /gene_set_names/1
  # GET /gene_set_names/1.json
  def show
  end

  # GET /gene_set_names/new
  def new
    @gene_set_name = GeneSetName.new
  end

  # GET /gene_set_names/1/edit
  def edit
  end

  # POST /gene_set_names
  # POST /gene_set_names.json
  def create
    @gene_set_name = GeneSetName.new(gene_set_name_params)

    respond_to do |format|
      if @gene_set_name.save
        format.html { redirect_to @gene_set_name, notice: 'Gene set name was successfully created.' }
        format.json { render :show, status: :created, location: @gene_set_name }
      else
        format.html { render :new }
        format.json { render json: @gene_set_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gene_set_names/1
  # PATCH/PUT /gene_set_names/1.json
  def update
    respond_to do |format|
      if @gene_set_name.update(gene_set_name_params)
        format.html { redirect_to @gene_set_name, notice: 'Gene set name was successfully updated.' }
        format.json { render :show, status: :ok, location: @gene_set_name }
      else
        format.html { render :edit }
        format.json { render json: @gene_set_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gene_set_names/1
  # DELETE /gene_set_names/1.json
  def destroy
    @gene_set_name.destroy
    respond_to do |format|
      format.html { redirect_to gene_set_names_url, notice: 'Gene set name was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gene_set_name
      @gene_set_name = GeneSetName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gene_set_name_params
      params.fetch(:gene_set_name, {})
    end
end
