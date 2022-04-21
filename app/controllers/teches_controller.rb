class TechesController < ApplicationController
  before_action :set_tech, only: %i[ show edit update destroy ]

  # GET /teches or /teches.json
  def index
    @teches = Tech.all
  end

  # GET /teches/1 or /teches/1.json
  def show
  end

  # GET /teches/new
  def new
    @tech = Tech.new
  end

  # GET /teches/1/edit
  def edit
  end

  # POST /teches or /teches.json
  def create
    @tech = Tech.new(tech_params)
    if @tech.user_id.nil?
      @tech.user = current_user
    end

    respond_to do |format|
      if @tech.save
        format.html { redirect_to tech_url(@tech), notice: "Tech was successfully created." }
        format.json { render :show, status: :created, location: @tech }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tech.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teches/1 or /teches/1.json
  def update
    respond_to do |format|
      if @tech.update(tech_params)
        format.html { redirect_to tech_url(@tech), notice: "Tech was successfully updated." }
        format.json { render :show, status: :ok, location: @tech }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tech.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teches/1 or /teches/1.json
  def destroy
    @tech.destroy

    respond_to do |format|
      format.html { redirect_to teches_url, notice: "Tech was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tech
      @tech = Tech.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tech_params
      params.require(:tech).permit(:name, :user_id)
    end
end
