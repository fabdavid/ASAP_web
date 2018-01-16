class DbSetsController < ApplicationController
  before_action :set_db_set, only: [:show, :edit, :update, :destroy]

  # GET /db_sets
  # GET /db_sets.json
  def index
    @db_sets = DbSet.all
  end

  # GET /db_sets/1
  # GET /db_sets/1.json
  def show
  end

  # GET /db_sets/new
  def new
    @db_set = DbSet.new
  end

  # GET /db_sets/1/edit
  def edit
  end

  # POST /db_sets
  # POST /db_sets.json
  def create
    @db_set = DbSet.new(db_set_params)

    respond_to do |format|
      if @db_set.save
        format.html { redirect_to @db_set, notice: 'Db set was successfully created.' }
        format.json { render :show, status: :created, location: @db_set }
      else
        format.html { render :new }
        format.json { render json: @db_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /db_sets/1
  # PATCH/PUT /db_sets/1.json
  def update
    respond_to do |format|
      if @db_set.update(db_set_params)
        format.html { redirect_to @db_set, notice: 'Db set was successfully updated.' }
        format.json { render :show, status: :ok, location: @db_set }
      else
        format.html { render :edit }
        format.json { render json: @db_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /db_sets/1
  # DELETE /db_sets/1.json
  def destroy
    @db_set.destroy
    respond_to do |format|
      format.html { redirect_to db_sets_url, notice: 'Db set was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_db_set
      @db_set = DbSet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def db_set_params
      params.fetch(:db_set).permit(:tag, :label, :tool_id)
    end
end
