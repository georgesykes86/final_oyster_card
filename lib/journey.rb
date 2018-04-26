class Journey
  attr_reader :entry_station, :exit_station, :fare

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @fare = 0
  end

  def add_exit_station(exit_station = nil)
    @exit_station = exit_station
    set_fare
  end

  def set_fare
    @fare = !entry_station || !exit_station ? 6 : 1
  end

  def complete?
    !!@exit_station && !!@entry_station
  end

end
