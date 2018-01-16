class GenesController < ApplicationController
  before_action :set_gene, only: [:show, :edit, :update, :destroy]


  def autocomplete
    to_render = []
    final_list=[]

    project = Project.find_by_key(params[:project_key])
    data_dir = Pathname.new(APP_CONFIG[:user_data_dir]) + project.user_id.to_s + project.key
    filename = data_dir + 'parsing' + "gene_names.json"
    #[["0610005C13RIK","ENSMUSG00000085214","0610005C13Rik"],["0610007C21RIK [Unmapped]","",""],["
    gene_list = JSON.parse(File.read(filename)).flatten
    h_genes = {}
    h_matches = {}
    gene_list.each do |identifier|
      identifier.split(",").each do |tmp|
        h_genes[tmp.downcase]=1
        if tmp.downcase.match(/#{params[:term].downcase}/)
          h_matches[tmp]=1
        end
      end
    end

    #    gene_list
    gene_names = []
    gene_names.push(GeneName.where("organism_id = ? and lower(value) = ?", params[:organism_id], params[:term].downcase).all)#.map{|e| e.gene_id}.uniq
    gene_names.push(GeneName.where("organism_id = ? and lower(value) ~ ?", params[:organism_id], params[:term].downcase).all)#.map{|e| e.gene_id}.uniq
    h_gene_names = {}
    h_all_gene_names = {}
    gene_names.each do |list|
      list.each do |gn|
        h_all_gene_names[gn.value.downcase]=1
        h_gene_names[gn.gene_id]||=[]
        h_gene_names[gn.gene_id].push(gn.value)
      end
    end
    #final_list= Gene.where("organism_id = ? and (lower(name) = ? or ensembl_id = ?)", params[:organism_id], params[:term].downcase, params[:term]).all
    #final_list |= Gene.where("organism_id = ? and (lower(name) ~ ? or ensembl_id ~ ?)", params[:organism_id], params[:term].downcase, params[:term]).order('name').all
    final_list = Gene.where(:id => gene_names[0].map{|e| e.gene_id}.uniq) | Gene.where(:id => gene_names[1].map{|e| e.gene_id}.uniq)
    #  final_list.to_a.reject!{|e| !h_genes[e.ensembl_id]}
    to_render = final_list.to_a.select{|e| h_genes[e.ensembl_id.downcase] or h_genes[e.name.downcase]}.first(20).map{|e| {:id => e.id, :label => "#{e.ensembl_id} #{e.name}" + ((e.alt_names.size > 0) ? " [" + e.alt_names.split(",").join(", ") + "]" : '')}}
    h_matches.keys.select{|k| !h_all_gene_names[k.downcase]}.each do |unfound_gene_name|
       to_render.push({:id =>'null', :label => unfound_gene_name + "Not found in Ensembl"})
    end
    render :text => to_render.to_json
  end


  # GET /genes
  # GET /genes.json
  def index
    @genes = Gene.all
  end

  # GET /genes/1
  # GET /genes/1.json
  def show
  end

  # GET /genes/new
  def new
    @gene = Gene.new
  end

  # GET /genes/1/edit
  def edit
  end

  # POST /genes
  # POST /genes.json
  def create
    @gene = Gene.new(gene_params)

    respond_to do |format|
      if @gene.save
        format.html { redirect_to @gene, notice: 'Gene was successfully created.' }
        format.json { render :show, status: :created, location: @gene }
      else
        format.html { render :new }
        format.json { render json: @gene.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /genes/1
  # PATCH/PUT /genes/1.json
  def update
    respond_to do |format|
      if @gene.update(gene_params)
        format.html { redirect_to @gene, notice: 'Gene was successfully updated.' }
        format.json { render :show, status: :ok, location: @gene }
      else
        format.html { render :edit }
        format.json { render json: @gene.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /genes/1
  # DELETE /genes/1.json
  def destroy
    @gene.destroy
    respond_to do |format|
      format.html { redirect_to genes_url, notice: 'Gene was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gene
      @gene = Gene.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gene_params
      params.fetch(:gene, {})
    end
end
