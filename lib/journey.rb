class Journey

  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil , exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @complete = false
  end

  def complete?
    @complete
  end

  def set_complete
    @complete = true
  end



end
