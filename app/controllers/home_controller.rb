class HomeController < ApplicationController
  
  def index
    @users = User.all
    @start_date = Date.today
    user_id = nil
    if current_user.admin?
      user_id = params[:id]
    elsif current_user.super?
      user_id = current_user
    else
      user_id = current_user.super_id
    end
    @reservations = Reservation.where day: @start_date.all_month, user_id: user_id
  end

end
