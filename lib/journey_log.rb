class Journeylog
  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station = nil)
    current_journey.set_complete if in_journey?
    create_journey(station)
  end

  def finish(station = nil)
    current_journey.set_complete(station)
  end

  def in_journey?
    !current_journey.complete?
  end

  def fare
    current_journey.fare
  end

  private

  def journeys
    @journeys
  end

  def current_journey
    create_journey if journeys.last.complete?
    journeys.last
  end

  def create_journey(station)
    journey = @journey_class.new(station)
    save(journey)
  end

  def save(journey)
    journeys << journey
  end

end
