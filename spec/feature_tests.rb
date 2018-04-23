# irb -r './spec/feature_tests.rb'

require './lib/oystercard'

def set_balance
  card = Oystercard.new
  p card
end

set_balance

def top_up
  card = Oystercard.new
  card.top_up(5)
  p card
end

top_up
