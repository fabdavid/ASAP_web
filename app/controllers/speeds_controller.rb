class SpeedsController < ApplicationController
  before_action :set_speed, only: [:show, :edit, :update, :destroy]

  # GET /speeds
  # GET /speeds.json
  def index
    @speeds = Speed.all
  end

  # GET /speeds/1
  # GET /speeds/1.json
  def show
  end

  # GET /speeds/new
  def new
    @speed = Speed.new
  end

  # GET /speeds/1/edit
  def edit
  end

  # POST /speeds
  # POST /speeds.json
  def create
    @speed = Speed.new(speed_params)

    respond_to do |format|
      if @speed.save
        format.html { redirect_to @speed, notice: 'Speed was successfully created.' }
        format.json { render :show, status: :created, location: @speed }
      else
        format.html { render :new }
        format.json { render json: @speed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /speeds/1
  # PATCH/PUT /speeds/1.json
  def update
    respond_to do |format|
      if @speed.update(speed_params)
        format.html { redirect_to @speed, notice: 'Speed was successfully updated.' }
        format.json { render :show, status: :ok, location: @speed }
      else
        format.html { render :edit }
        format.json { render json: @speed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /speeds/1
  # DELETE /speeds/1.json
  def destroy
    @speed.destroy
    respond_to do |format|
      format.html { redirect_to speeds_url, notice: 'Speed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_speed
      @speed = Speed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def speed_params
      #      params.fetch(:speed, {})
      params.fetch(:speed).permit(:name, :logo)
    end
end
