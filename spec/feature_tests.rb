# irb -r './spec/feature_tests.rb'

require './lib/oystercard'

def set_balance
  card = Oystercard.new(balance = 0)
  p card 
end

set_balance
