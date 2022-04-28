module ReservationsHelper

  def findReservation( events, hour )
    events.find{ |e| e[:start_time].hour == hour }
  end

  def is_used(events, hour)
    events.find{ |e| hour.between?(e[:start_time].hour, e[:end_time].hour )}
  end

end
