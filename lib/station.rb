require_relative './station_checker'

class Station

attr_reader :name, :zone

  def initialize(name, station_checker = Stationchecker.new)
    @name = name
    @station_checker = station_checker
    @zone = get_zone(name)
  end

  def get_zone(name)
    @station_checker.check_zone(name)
  end

end
