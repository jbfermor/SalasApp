module ReservationsHelper

  def findReservation( events, hour )
    events.find{ |e| e[:start_time].strftime("%H") == hour.to_s }
  end

  def is_used(events, hour)
    events.find{ |e| hour.to_s.between?(e[:start_time].strftime("%H"), e[:end_time].strftime("%H") )}
  end

end
