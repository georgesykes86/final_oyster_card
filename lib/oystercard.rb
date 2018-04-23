class Oystercard

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1
  attr_reader :balance, :in_journey, :entry_station

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
    @entry_station = nil
  end

  def top_up(money)
    fail "Maximum balance of #{MAX_BALANCE} exceeded" if (@balance + money) > MAX_BALANCE
    @balance += money
  end

  def in_journey?
    @in_journey
  end

  def touch_in(entry_station)
    fail "Minimum balance of #{MIN_BALANCE} required" if @balance < MIN_BALANCE
    @in_journey = true
    @entry_station = entry_station
  end

  def touch_out
    deduct(MIN_FARE)
    @in_journey = false
  end

  private

  def deduct(money)
    @balance -= money
  end

end
