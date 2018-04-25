# require 'pry'
# require 'pry-byebug'
class Journey

  MIN_FARE = 1
  attr_reader :entry_station, :exit_station, :fare

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
  end

  def complete?
    @complete
  end

  def set_complete(station = nil)
    @complete = true
    set_exit_station(station)
    set_fare
  end

  def set_exit_station(station)
    @exit_station = station
  end

  def set_fare
    @fare = MIN_FARE
  end

end
