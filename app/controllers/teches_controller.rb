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
    @tech.user = current_user if @tech.user_id.nil?

      if @tech.save
        redirect_to tech_url(@tech), notice: "Tech was successfully created." 
      else
        render :new, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /teches/1 or /teches/1.json
  def update
      if @tech.update(tech_params)
        redirect_to tech_url(@tech), notice: "Tech was successfully updated." 
      else
        render :edit, status: :unprocessable_entity 
      end
  end

  # DELETE /teches/1 or /teches/1.json
  def destroy
    Tech.friendly.find(params[:id]).destroy
    redirect_to teches_url, notice: "Tech was successfully destroyed."   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tech
      @tech = Tech.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tech_params
      params.require(:tech).permit(:name, :user_id)
    end
end
