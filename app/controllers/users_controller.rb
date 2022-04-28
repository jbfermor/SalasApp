class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    if current_user.admin?
      usuario = User.find(params[:id])
      @subordinates = User.where super_id: usuario
      @teches = Tech.all
      @rooms = Room.all
      if usuario.user?
        @teches = Tech.where user_id: usuario.super_id
        @rooms = Room.where user_id: User.find(params[:id]).super_id
        @reservations = Reservation.where user_id: User.find(params[:id]).super_id
      elsif usuario.super?
        @teches = Tech.where user_id: usuario
        @rooms = Room.where user_id: usuario
        @reservations = Reservation.where user_id: usuario
      end
    elsif current_user.super?
      @subordinates = User.where super_id: current_user.id
      @teches = Tech.where user_id: current_user.id
      @rooms = Room.where user_id: current_user.id
      @reservations = Reservation.where user_id: current_user.id
    elsif current_user.user?
      @subordinates = nil
      @teches = Tech.where user_id: current_user.super_id
      @rooms = Room.where user_id: current_user.super_id
      @reservations = Reservation.where user_id: current_user.super_id
    end 
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    if @user.role_id.blank?
      @user.role_id = 3
    end

    if current_user.user? 
      format.html { redirect_to user_url(@user), notice: "No tienes permiso para crear usuarios" }
    end

    if @user.super_id.blank?
      @user.super_id = current_user.id
    end
    

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_path, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :nif, :name, 
        :address, :city, :pc, :province, :phone, :email2, 
        :role_id, :super_id)
    end
end
