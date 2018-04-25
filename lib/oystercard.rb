class Oystercard

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1
  attr_reader :balance, :entry_station, :journeys

  def initialize(balance: DEFAULT_BALANCE, journey_class: Journey)
    @balance = balance
    @entry_station = nil
    @journeys = []
    @journey_class = journey_class
  end

  def top_up(money)
    fail "Maximum balance of #{MAX_BALANCE} exceeded" if (@balance + money) > MAX_BALANCE
    @balance += money
  end

  def in_journey?
    !!current_journey && !current_journey.complete?
  end

  def touch_in(entry_station)
    fail "Minimum balance of #{MIN_BALANCE} required" if @balance < MIN_BALANCE
    journey = create_journey(entry_station)
    save(journey)
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    current_journey.set_complete(exit_station)
  end

  private

  def deduct(money)
    @balance -= money
  end

  def save(journey)
    journeys << journey
  end

  def current_journey
    journeys.last
  end

  def create_journey(station)
    @journey_class.new(station)
  end

end
