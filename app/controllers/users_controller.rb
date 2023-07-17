class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :is_user
  before_action :is_super, only: %i[ index ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    usuario = User.friendly.find(params[:id])
    if current_user.admin? 
      @subordinates = User.where super_id: usuario
      @teches = Tech.all
      @rooms = Room.all
    else
      user_id = nil
      if usuario.user?
        user_id = usuario.super_id
      elsif usuario.super?
        user_id = usuario
      end
      if current_user.super?
        user_id = current_user.id
        @subordinates = User.where super_id: user_id
      elsif current_user.user?
        @subordinates = nil
        user_id = current_user.super_id
      end
      @teches = Tech.where user_id: user_id
      @rooms = Room.where user_id: user_id
      @reservations = Reservation.where user_id: user_id
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
    @user.check_ids

    if current_user.user? 
      redirect_to user_url(@user), notice: "No tienes permiso para crear usuarios" 
    elsif @user.save
        redirect_to @user, notice: "User was successfully created." 
    else
        render :new, status: :unprocessable_entity 
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
      if @user.update(user_params)
        redirect_to user_url(@user), notice: "User was successfully updated." 
      else
        render :edit, status: :unprocessable_entity 
      end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    User.friendly.find(params[:id]).destroy
    redirect_to users_path, notice: "User was successfully destroyed." 
  end

  private

  def is_user
    if current_user.user?
      redirect_to root_path 
    end
  end

  def is_super
    if current_user.super?
      redirect_to root_path 
    end
  end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :nif, :name, 
        :address, :city, :pc, :province, :phone, :email2, 
        :role_id, :super_id)
    end
end
