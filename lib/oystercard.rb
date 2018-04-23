class Oystercard

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  attr_reader :balance, :in_journey

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(money)
    fail "Maximum balance of #{MAX_BALANCE} exceeded" if (@balance + money) > MAX_BALANCE
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Minimum balance of #{MIN_BALANCE} required" if @balance < MIN_BALANCE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
