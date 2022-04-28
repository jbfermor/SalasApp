class HomeController < ApplicationController
  
  def index
    @users = User.all

    @start_date = Date.today
    if current_user.admin?
      @reservations = Reservation.where day: @start_date.all_month, user_id: params[:id]
    elsif current_user.super?
      @reservations = Reservation.where day: @start_date.all_month, user_id: current_user
    else
      @reservations = Reservation.where day: @start_date.all_month, user_id: current_user.super_id
    end

  end

end
