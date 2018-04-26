require 'csv'

class Stationchecker

  def initialize(station_path = './resources/stations.csv')
    @station_path = station_path
  end

  def get_similar_names(name)
    similar_names = []
    CSV.foreach(@station_path) do |line|
      station = line[0]
      similar_names << station if match?(name, station)
    end

  end

  def check_zone(name)
    CSV.foreach(@station_path) do |line|
      station, zone = line
      return zone.to_i if station == name
    end
    raise "Station not recognized did you mean?\n #{print_similar_names}"
  end

  def match?(name)
    regexs = create_matchers(name)
    regexs.each do |matcher|
      regex = /\b#{Regex.quote(matcher)}/
      return true if regex.match(station)
    end
    false
  end

  def create_matchers(name)
    [name[0..3], name[0..2], name[0..1], name[0]]
  end

  def print_similar_names(name)
    get.similar_names(name).each_slice(3) do |slice|
      puts slice.join("    ")
    end
  end

end
