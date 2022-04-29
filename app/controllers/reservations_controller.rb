class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]
  before_action :set_select_collections, only: [:edit, :update, :new, :create]
  before_action :set_start_date
  before_action :is_not_admin

  # GET /reservations or /reservations.json
  def index
    @rooms = current_user.rooms
    if params[:table].present?
      if current_user.super?
        @reservations = Reservation.where(day: @start_date, user_id: current_user).order(:start_time)
      else
        @reservations = Reservation.where(day: @start_date, user_id: current_user.super_id).order(:start_time)
      end
    else
      if current_user.super?
        @reservations = Reservation.where(day: @start_date.all_month, user_id: current_user).order(:start_time)
      else
        @reservations = Reservation.where(day: @start_date.all_month, user_id: current_user.super_id).order(:start_time)
      end
    end
    
    @hours = (8..22).to_a
    
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

    set_new_reservation(@reservation)
    
    if occupied?(@reservation)
        redirect_to reservations_path, alert: "Ya hay una reserva para esa fecha y hora"
    else
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
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update

    @reservation.update(reservation_params)
    @reservation.end_time = @reservation.end_time - 1.minute

    if occupied?(@reservation)
      redirect_to reservations_path, alert: "Ya hay una reserva para esa fecha y hora"
    else
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
    def is_not_admin
      if current_user.admin?
        flash[:alert] = "Un administrador no puede gestionar reservas"
        redirect_to root_path 
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def set_new_reservation(reservation)
      reservation.day = Date.civil(params[:reservation]["day(1i)"].to_i, 
      params[:reservation]["day(2i)"].to_i, 
      params[:reservation]["day(3i)"].to_i)
      reservation.start_time = Time.new(params[:reservation]["day(1i)"].to_i,
      params[:reservation]["day(2i)"].to_i,
      params[:reservation]["day(3i)"].to_i,
      params[:reservation]["start_time(4i)"].to_i,
      params[:reservation]["start_time(5i)"].to_i)

      if params[:reservation]["end_time(5i)"] == "00"
        reservation.end_time = Time.new(params[:reservation]["day(1i)"].to_i,
        params[:reservation]["day(2i)"].to_i, 
        params[:reservation]["day(3i)"].to_i,
        params[:reservation]["end_time(4i)"].to_i - 1,
        59)
      else
        reservation.end_time = Time.new(params[:reservation]["day(1i)"].to_i,
        params[:reservation]["day(2i)"].to_i, 
        params[:reservation]["day(3i)"].to_i,
        params[:reservation]["end_time(4i)"].to_i,
        29)
      end

    reservation.room_id = params[:reservation]["room_id"].to_i
    reservation.user_id = current_user.id if params[:user_id].nil?
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

    def set_start_date
      if params[:start_date].present?
        @start_date = params[:start_date].to_date
      else
        @start_date = Date.today
      end
    end

    def occupied?(reservation)
      if current_user.super?
        reservations_today = Reservation.where day: @start_date.all_day, user_id: current_user
      else
        reservations_today = Reservation.where day: @start_date.all_day, user_id: current_user.super_id
      end

      done = false

      reservations_today.each do |r|
        next if reservation.id == r.id
        if r.start_time.between?(reservation.start_time, reservation.end_time) || r.end_time.between?(reservation.start_time, reservation.end_time)
          if r.room_id == reservation.room_id
            done = true
          end
        end
      end

      done

    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:day, :start_time, :end_time, :title, :description, :tools, :others, :user_id, :room_id, :tech_id)
    end

end
