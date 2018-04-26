class Journeylog

  def initialize(journey_class = Journey)
    @journey_history = []
    @journey_class = journey_class
    @current_journey = nil
    @fare = 0
  end

  def start(entry_station)
    reset_fare
    finish if @current_journey
    create_journey(entry_station)
  end

  def finish(exit_station = nil)
    current_journey.add_exit_station(exit_station)
    save_journey(current_journey)
    set_fare
    reset_current_journey
  end

  def journeys
    @journey_history.dup
  end

  def fare
    @fare
  end

  def in_journey?
    @current_journey
  end

  private

  def create_journey(entry_station = nil)
    @current_journey = @journey_class.new(entry_station)
  end

  def current_journey
    @current_journey ||= create_journey
  end

  def save_journey(journey)
    @journey_history << journey
  end

  def set_fare
    @fare = journeys.last.fare
  end

  def reset_fare
    @fare = 0
  end

  def reset_current_journey
    @current_journey = nil
  end
end
