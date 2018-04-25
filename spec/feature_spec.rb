feature 'Oystercard Challenge', :feature do
  let(:oystercard) { Oystercard.new }
  let(:entry_station) { Station.new('Oxford Circus', 1) }
  let(:exit_station) { Station.new('Oxford Circus', 1) }

  before do
    oystercard.top_up(10)
  end

  scenario 'creating a journey on touch in' do
    oystercard.touch_in(entry_station)
    expect(oystercard).to be_in_journey
  end

  scenario 'completes a valid journey on touch out' do
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard).not_to be_in_journey
    expect(oystercard.journeys.last.entry_station).to be entry_station
    expect(oystercard.journeys.last.exit_station).to be exit_station
  end
end
