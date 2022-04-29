module ReservationsHelper

  def findReservation( events, hour )
    events.find{ |e| e[:start_time].hour == hour }
  end

  def is_used(events, hour)
    events.select{ |e| hour.between?(e[:start_time].hour, e[:end_time].hour )}
  end

  def finished?(event)
    event.end_time < Time.now
  end

  def loading?(event)
    Time.now.between?(event.start_time, event.end_time)
  end

  def state_style(event)
    if event.end_time < Time.now
      "text-decoration-line-through"
    elsif Time.now.between? event.start_time, event.end_time
      "bg-warning"
    else
      "bg-success"
    end
  end

end
