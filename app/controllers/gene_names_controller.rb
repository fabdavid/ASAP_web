class GeneNamesController < ApplicationController
  before_action :set_gene_name, only: [:show, :edit, :update, :destroy]

  # GET /gene_names
  # GET /gene_names.json
  def index
    @gene_names = GeneName.all
  end

  # GET /gene_names/1
  # GET /gene_names/1.json
  def show
  end

  # GET /gene_names/new
  def new
    @gene_name = GeneName.new
  end

  # GET /gene_names/1/edit
  def edit
  end

  # POST /gene_names
  # POST /gene_names.json
  def create
    @gene_name = GeneName.new(gene_name_params)

    respond_to do |format|
      if @gene_name.save
        format.html { redirect_to @gene_name, notice: 'Gene name was successfully created.' }
        format.json { render :show, status: :created, location: @gene_name }
      else
        format.html { render :new }
        format.json { render json: @gene_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gene_names/1
  # PATCH/PUT /gene_names/1.json
  def update
    respond_to do |format|
      if @gene_name.update(gene_name_params)
        format.html { redirect_to @gene_name, notice: 'Gene name was successfully updated.' }
        format.json { render :show, status: :ok, location: @gene_name }
      else
        format.html { render :edit }
        format.json { render json: @gene_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gene_names/1
  # DELETE /gene_names/1.json
  def destroy
    @gene_name.destroy
    respond_to do |format|
      format.html { redirect_to gene_names_url, notice: 'Gene name was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gene_name
      @gene_name = GeneName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gene_name_params
      params.fetch(:gene_name, {})
    end
end
