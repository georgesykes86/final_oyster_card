feature 'Oystercard Challenge', :feature do
  let(:oystercard) { Oystercard.new }
  let(:station) { Station.new('Oxford Circus', 1) }
  scenario 'creating a journey on touch in' do
    oystercard.top_up(10)
    oystercard.touch_in(station)
    expect(oystercard.in_journey?).to be true
  end
end
