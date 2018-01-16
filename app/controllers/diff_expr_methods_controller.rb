class DiffExprMethodsController < ApplicationController
  before_action :set_diff_expr_method, only: [:show, :edit, :update, :destroy]

  # GET /diff_expr_methods
  # GET /diff_expr_methods.json
  def index
    @diff_expr_methods = DiffExprMethod.all
  end

  # GET /diff_expr_methods/1
  # GET /diff_expr_methods/1.json
  def show
  end

  # GET /diff_expr_methods/new
  def new
    @diff_expr_method = DiffExprMethod.new
  end

  # GET /diff_expr_methods/1/edit
  def edit
  end

  # POST /diff_expr_methods
  # POST /diff_expr_methods.json
  def create
    @diff_expr_method = DiffExprMethod.new(diff_expr_method_params)

    respond_to do |format|
      if @diff_expr_method.save
        format.html { redirect_to @diff_expr_method, notice: 'Diff expr method was successfully created.' }
        format.json { render :show, status: :created, location: @diff_expr_method }
      else
        format.html { render :new }
        format.json { render json: @diff_expr_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diff_expr_methods/1
  # PATCH/PUT /diff_expr_methods/1.json
  def update
    respond_to do |format|
      if @diff_expr_method.update(diff_expr_method_params)
        format.html { redirect_to @diff_expr_method, notice: 'Diff expr method was successfully updated.' }
        format.json { render :show, status: :ok, location: @diff_expr_method }
      else
        format.html { render :edit }
        format.json { render json: @diff_expr_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diff_expr_methods/1
  # DELETE /diff_expr_methods/1.json
  def destroy
    @diff_expr_method.destroy
    respond_to do |format|
      format.html { redirect_to diff_expr_methods_url, notice: 'Diff expr method was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diff_expr_method
      @diff_expr_method = DiffExprMethod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diff_expr_method_params
#      params.fetch(:diff_expr_method, {})
      params.fetch(:diff_expr_method).permit(:name, :label, :description, :attrs_json, :program, :link, :speed_id, :creates_av_norm, :handles_log)
    end
end
