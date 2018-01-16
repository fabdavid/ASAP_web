class ToolTypesController < ApplicationController
  before_action :set_tool_type, only: [:show, :edit, :update, :destroy]

  # GET /tool_types
  # GET /tool_types.json
  def index
    @tool_types = ToolType.all
  end

  # GET /tool_types/1
  # GET /tool_types/1.json
  def show
  end

  # GET /tool_types/new
  def new
    @tool_type = ToolType.new
  end

  # GET /tool_types/1/edit
  def edit
  end

  # POST /tool_types
  # POST /tool_types.json
  def create
    @tool_type = ToolType.new(tool_type_params)

    respond_to do |format|
      if @tool_type.save
        format.html { redirect_to @tool_type, notice: 'Tool type was successfully created.' }
        format.json { render :show, status: :created, location: @tool_type }
      else
        format.html { render :new }
        format.json { render json: @tool_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tool_types/1
  # PATCH/PUT /tool_types/1.json
  def update
    respond_to do |format|
      if @tool_type.update(tool_type_params)
        format.html { redirect_to @tool_type, notice: 'Tool type was successfully updated.' }
        format.json { render :show, status: :ok, location: @tool_type }
      else
        format.html { render :edit }
        format.json { render json: @tool_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tool_types/1
  # DELETE /tool_types/1.json
  def destroy
    @tool_type.destroy
    respond_to do |format|
      format.html { redirect_to tool_types_url, notice: 'Tool type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tool_type
      @tool_type = ToolType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tool_type_params
      params.fetch(:tool_type).permit(:name)
    end
end
