class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]
  before_action :set_select_collections, only: [:edit, :update, :new, :create]

  # GET /reservations or /reservations.json
  def index
    if current_user.admin?
      @reservations = Reservation.where user_id: params[:id]
    elsif current_user.super?
      @reservations = Reservation.where user_id: current_user
    else
      @reservations = Reservation.where user_id: current_user.super_id
    end
    
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
    
    
    
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations or /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.day = Date.civil(params[:reservation]["day(1i)"].to_i, 
      params[:reservation]["day(2i)"].to_i, 
      params[:reservation]["day(3i)"].to_i)
    @reservation.start_time = Time.new(params[:reservation]["start_time(1i)"].to_i,
      params[:reservation]["start_time(2i)"].to_i,
      params[:reservation]["start_time(3i)"].to_i,
      params[:reservation]["start_time(4i)"].to_i,
      params[:reservation]["start_time(5i)"].to_i)
    @reservation.end_time = Time.new(params[:reservation]["end_time(1i)"].to_i,
      params[:reservation]["end_time(2i)"].to_i, 
      params[:reservation]["end_time(3i)"].to_i,
      params[:reservation]["end_time(4i)"].to_i,
      params[:reservation]["end_time(5i)"].to_i)
    @reservation.room_id = params[:reservation]["room_id"].to_i
    

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully created." }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to reservation_url(@reservation), notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url, notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def set_select_collections
      if current_user.admin?
        @rooms = Room.where user_id: params[:user_id]
        @teches = Tech.where user_id: params[:user_id]
      elsif current_user.super?
        @rooms = Room.where user_id: current_user
        @teches = Tech.where user_id: current_user
      else
        @rooms = Room.where user_id: current_user.super_id
        @teches = Tech.where user_id: current_user.super_id
      end
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:day, :start_time, :end_time, :title, :description, :tools, :others, :user_id, :room_id, :tech_id)
    end
end
