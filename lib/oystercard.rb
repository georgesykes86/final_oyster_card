require_relative './journey'
require_relative './station'
require_relative './journey_log'

class Oystercard
  attr_reader :balance

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  def initialize(journey_log = Journeylog.new)
    @balance = DEFAULT_BALANCE
    @journey_log = journey_log
  end

  def in_journey?
    journey_log.in_journey?
  end

  def touch_in(entry_station)
    raise 'Minimum card balance required' if insufficient_funds?
    journey_log.start(entry_station)
    deduct(get_fare)
  end

  def touch_out(exit_station)
    journey_log.finish(exit_station)
    deduct(get_fare)
  end

  def top_up(value)
    raise "Maximum limit of £#{MAX_BALANCE} exceeded" if exceeds_max_balance?(value)
    @balance += value
  end

  def journeys
    journey_log.journeys
  end

  private

  attr_reader :journey_log

  def deduct(value)
    raise 'Invalid amount' if value < 0
    @balance -= value
  end

  def get_fare
    journey_log.fare
  end

  def insufficient_funds?
    @balance < MIN_BALANCE
  end

  def exceeds_max_balance?(value)
    @balance + value > MAX_BALANCE
  end

end
