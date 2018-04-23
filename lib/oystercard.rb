class Oystercard

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(money)
    fail "Maximum balance of #{MAX_BALANCE} exceeded" if (@balance + money) > MAX_BALANCE
    @balance += money
  end

  def deduct(money)
    @balance -= money
  end
  
end
