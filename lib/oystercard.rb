class Oystercard

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1
  attr_reader :balance, :entry_station, :journeys

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station = nil
    @journeys = []
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
    @journeys << Journey.new(entry_station)
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    save_journey(exit_station)
    @entry_station = nil
  end

  private

  def deduct(money)
    @balance -= money
  end

  def save_journey(exit_station)
    journeys << {entry: entry_station, exit: exit_station}
  end

  def current_journey
    journeys.last
  end

end
