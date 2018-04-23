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

def max_balance
  card = Oystercard.new
  card.top_up(91)
  p card
end

#max_balance

def deduct
  card = Oystercard.new
  card.top_up(10)
  card.deduct(5)
  p card
end

#deduct

def check_status
  card = Oystercard.new
  p card.in_journey?
  p card.touch_in('station')
  p card.touch_out('station2')
end

def min_amount
  card = Oystercard.new
  card.touch_in('station')
  p card
end

# min_amount

def deduct_money_touch_out
  card = Oystercard.new
  card.top_up(10)
  card.touch_in('station')
  card.touch_out('station2')
  p card
end

deduct_money_touch_out


def entry_station
  card = Oystercard.new
  card.top_up(10)
  card.touch_in('station')
  p card.entry_station
end

entry_station

def entry_station_touch_out
  card = Oystercard.new
  card.top_up(10)
  card.touch_in('station')
  card.touch_out('station2')
  p card.entry_station
end

entry_station_touch_out

def default_journey_history
  card = Oystercard.new
  card.top_up(10)
  p card.journeys
end

default_journey_history

# hash with entry and exit station
def store_journey
  card = Oystercard.new
  card.top_up(10)
  card.touch_in('station')
  card.touch_out('station2')
  p card.journeys
end

store_journey

def create_station
  p Station.new(name, zone)
end

create_station
