class GeneSetsController < ApplicationController
  before_action :set_gene_set, only: [:show, :edit, :update, :destroy]
  before_action :set_cart_display, only: [:index, :create, :update, :destroy]

  def autocomplete
    to_render = []
    final_list=[]
    
    ###    project = Project.find_by_key(params[:project_key])
    logger.debug("VIZ_PARAMS:" + session[:viz_params].to_json)
    gene_set_id = (session[:viz_params]['geneset_type'] == 'global') ? session[:viz_params]['global_geneset'] : session[:viz_params]['custom_geneset']
    gene_set = GeneSet.find(gene_set_id)
    filename = ''
    if gene_set.project_id ### specific project gene set
      project = gene_set.project
      dir = Pathname.new(APP_CONFIG[:user_data_dir]) + project.user_id.to_s + project.key + 'gene_sets'
      filename = dir + (gene_set.id.to_s + '.txt')
    else ### global gene set
      dir = Pathname.new(APP_CONFIG[:data_dir]) + "Genesets"
      filename = dir + gene_set.original_filename
    end

    results = `grep -i '#{params[:term]}' #{filename}`.split("\n")

    h_res={:count => results.size}
    i=0
    results.sort{|a, b| [a.downcase, a] <=> [b.downcase, b]}.each do |e|
      t = e.split("\t")
      s = t.size - 3 #((session[:viz_params]['geneset_type'] == 'global') ? 3 : 2)
      to_render.push({:id => e[0], :label => "#{t[0]}" + ((!['', 'null'].include?(t[1])) ? " : #{t[1]}" : '') + " [#{s} genes]" })
      i+=1
      break if i == 20
    end
    h_res[:data]=to_render
    #[["0610005C13RIK","ENSMUSG00000085214","0610005C13Rik"],["0610007C21RIK [Unmapped]","",""],["                                                                                               
   # gene_list = JSON.parse(File.read(filename)).map{|e| e[1]}
   # h_genes = {}
   # gene_list.each do |ensembl_id|
   #   h_genes[ensembl_id]=1
   # end
    
    #    gene_list                                                                                                                                                                               
   # final_list= Gene.where("organism_id = ? and (lower(name) ~ ? or ensembl_id ~ ?)", params[:organism_id], params[:term].downcase, params[:term]).all
    #  final_list.to_a.reject!{|e| !h_genes[e.ensembl_id]}                                                                                                                                       
   # to_render = final_list.to_a.select{|e| h_genes[e.ensembl_id]}.map{|e| {:id => e.id, :label => "#{e.ensembl_id} [#{e.name}]"}}.first(10)
    

    render :text => h_res.to_json #to_render.sort{|a, b| [a[:label].downcase,a[:label]]  <=> [b[:label].downcase, b[:label]]}.to_json
  end

  def set_cart_display
    session[:cart_display]='genesets'
  end

  # GET /gene_sets
  # GET /gene_sets.json
  def index
    if admin?
      @gene_sets = GeneSet.where(:project_id => nil).all
      base_dir = Pathname.new(APP_CONFIG[:data_dir]) + 'Genesets'


    end
  end

  # GET /gene_sets/1
  # GET /gene_sets/1.json
  def show
  end

  # GET /gene_sets/new
  def new
    if admin?
      @gene_set = GeneSet.new
      base_dir = Pathname.new(APP_CONFIG[:data_dir]) + 'Genesets'
    
    end
  end

  # GET /gene_sets/1/edit
  def edit
  end

  # POST /gene_sets
  # POST /gene_sets.json
  def create    

    @gene_set = GeneSet.new(gene_set_params)

    if params[:project_key]
      
      @project = Project.where(:key => params[:project_key]).first

      if authorized?
        gene_sets_dir = Pathname.new(APP_CONFIG[:user_data_dir]) + @project.user_id.to_s + @project.key + 'gene_sets'
        Dir.mkdir gene_sets_dir if !File.exist? gene_sets_dir
        
        @gene_set.user_id = @project.user_id
        @gene_set.project_id = @project.id
        @gene_set.organism_id = @project.organism_id
        
        if params[:diff_expr_id]
          
          diff_expr = DiffExpr.where(:id => params[:diff_expr_id], :project_id => @project.id).first
          
          de_dir = Pathname.new(APP_CONFIG[:user_data_dir]) + @project.user_id.to_s + @project.key + 'de' + diff_expr.id.to_s
          
          h_params_de = JSON.parse(@project.diff_expr_filter_json)
          
          tab_label = diff_expr.short_label.split(" ")
          new_label = tab_label[0]
          param_label = []
          if tab_label.size > 1 and m = tab_label[1].match(/\[(.+)?\]/)
            param_label = m[1].split(",")
          end
          h_params_de.each_key do |k|
            param_label.push(h_params_de[k])
          end
          new_label += " [#{param_label.join(',')}]" if param_label.size > 0
          
          
          @gene_sets = GeneSet.where("label ~ ? and project_id = ?", new_label.gsub("-", "\\-"), @gene_set.project_id).all
          max = nil
          @gene_sets.each do |gene_set|
            t = gene_set.label.split(" ")
            last_value = t.last
            if last_value.to_i.to_s == last_value and last_value.to_i > max
              max = last_value.to_i
            end
          end
          
          # user_id | project_id | organism_id | name | original_filename | diff_expr_id    
          @gene_set.label = new_label + ((max) ? (" " + (max+1).to_s) : '')
          @gene_set.ref_id = diff_expr.id
          @gene_set.nb_items = 3
          
          if @gene_set.save
            #      h = {}
            gene_set_filename = gene_sets_dir + (@gene_set.id.to_s + '.txt')
            
            both = []
            
            File.open(gene_set_filename, 'w') do |f|
              ['down', 'up'].each do |k|
                filename = de_dir +  ("output." + k + "_filtered.json")
                filename = de_dir +  ("output." + k + ".json")  if !File.exist? filename
                results = JSON.parse(File.read(filename))
                if results['text']
                  gene_names = results['text'].map{|e| e.split("|").first}
                  f.write([k, "", '',  gene_names].flatten.join("\t") + "\n")
                  both += gene_names
                end
              end
              f.write(["both", "", "", both.uniq].flatten.join("\t") + "\n")
            end
          end
          
        elsif params[:gene_set_file]
          logger.debug("Can see  params[:gene_set_file]  => #{params[:gene_set_file].original_filename}")
          # @gene_set.label = "No name"
          @gene_set.original_filename = params[:gene_set_file].original_filename
          #          if @gene_set.original_filename.match(/(.+)\.?/)
          splitted_label =  @gene_set.original_filename.split(".")
          splitted_label.pop if splitted_label.size > 1
          @gene_set.label = splitted_label.join(".")
         #  @gene_set.label = "No name"
          if @gene_set.save
            gene_set_filename = gene_sets_dir + (@gene_set.id.to_s + '.txt')
            File.open(gene_set_filename, "w") do |f|
#             logger.debug("BEURK: " + gene_set_filename)
              params[:gene_set_file].read.split("\n").flatten.each do |l|
                #    while (l = f.gets) do
#                logger.debug("--->line:" + l)
                tab = l.split("\t")
                #   new_tab= []
                #   if tab.size == 2
                new_tab = [tab[0], tab[1], ""]
                #   else
                
                (2 .. (tab.size-1)).to_a.each do |i|
                  new_tab.push(tab[i])
                end
                f.write(new_tab.join("\t") + "\n")
              end
              
            end
          end
          @gene_set.update_attribute(:nb_items, `wc -l #{gene_set_filename}`)
          
        end
        #      redirect_to :controller => 'diff_exprs', :action => 'index'
        render :text => "refresh('cart', '" + get_cart_projects_path(:project_key => @project.key) + "')"
      else
         render :nothing => true
      end

    else ### case of a global gene set
      
      
      filename = Pathname.new(APP_CONFIG[:data_dir]) + "Genesets" + @gene_set.original_filename
      
      if File.exist?(filename) and admin?
        @gene_set.nb_items = `wc -l #{filename}`.to_i
        @gene_set.user_id = 1
        respond_to do |format|
          if @gene_set.save
            format.html { redirect_to @gene_set, notice: 'Gene set was successfully created.' }
            format.json { render :show, status: :created, location: @gene_set }
          else
            format.html { render :new }
            format.json { render json: @gene_set.errors, status: :unprocessable_entity }
          end
        end
      else
        render :nothing => true
      end
      
    end
  end

  # PATCH/PUT /gene_sets/1
  # PATCH/PUT /gene_sets/1.json
  def update
    if authorized?
      respond_to do |format|
        if @gene_set.update(gene_set_params)
          format.html { 
            if @gene_set.project_id
              render :text => "refresh('cart', '" + get_cart_projects_path(:project_key => @project.key) + "')"
              #redirect_to @gene_set, notice: 'Gene set was successfully updated.' 
            else
              redirect_to @gene_set, notice: 'Gene set was successfully updated.'
            end
            }
          format.json { render :show, status: :ok, location: @gene_set }
        else
          format.html { render :edit }
          format.json { render json: @gene_set.errors, status: :unprocessable_entity }
        end
      end
    else
      render :nothing => true
    end
  end

  # DELETE /gene_sets/1
  # DELETE /gene_sets/1.json
  def destroy
    if authorized?
      @gene_set.destroy
      respond_to do |format|
        format.html { 
          render :text => 'Done'
          #          render :text => "refresh('cart', '" + get_cart_projects_path(:project_key => @project.key) + "')"
          #redirect_to gene_sets_url, notice: 'Gene set was successfully destroyed.' 
        }
        format.json { head :no_content }
      end
    else
      render :nothing => true
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gene_set
      @gene_set = GeneSet.find(params[:id])
      @project = @gene_set.project
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gene_set_params
      params.fetch(:gene_set).permit(:project_id, :organism_id, :label, :original_filename, :ref_id, :nb_items)
    end
end
