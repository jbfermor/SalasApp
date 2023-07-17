class RoomsController < ApplicationController
  before_action :set_room, only: %i[ show edit update destroy ]
  

  # GET /rooms or /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1 or /rooms/1.json
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)
    @room.user_nil?

      if @room.save
        redirect_to room_url(@room), notice: "Room was successfully created." 
      else
        render :new, status: :unprocessable_entity 
      end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
      if @room.update(room_params)
        redirect_to room_url(@room), notice: "Room was successfully updated." 
      else
        render :edit, status: :unprocessable_entity 
      end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    Room.friendly.find(params[:id]).destroy
    redirect_to rooms_url, notice: "Room was successfully destroyed." 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:name, :user_id)
    end
end
