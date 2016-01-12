require 'oystercard'
describe Oystercard do
  let(:oystercard) { described_class.new }
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }
  let(:journey) { {journey0: {entry_station: entry_station, exit_station: exit_station}} }
  it 'has a balance' do
    expect(oystercard.balance).to eq(0)
  end

  it 'can be topped up' do
    expect { oystercard.top_up(20) }.to change { oystercard.balance }.by(20)
  end

  it 'has a maximum balance' do
    error = "Max balance #{Oystercard::MAX_BALANCE} reached"
    oystercard.top_up(50)
    expect { oystercard.top_up(1) }.to raise_error error
  end

  it 'is instantiated as not in journey' do
    expect(oystercard).not_to be_in_journey
  end

  it 'is in journey after touch in' do
    oystercard.top_up(10)
    oystercard.touch_in(entry_station)
    expect(oystercard).to be_in_journey
  end

  it 'is not in journey after touch out' do
    oystercard.top_up(10)
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard).not_to be_in_journey
  end

  it 'must have minimum balance of £1 to start journey' do
    error = "Insuffient funds"
    expect { oystercard.touch_in(entry_station) }.to raise_error error
  end

  it 'charges on touch_out' do
    oystercard.top_up(10)
    oystercard.touch_in(entry_station)
    expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by(-1)
  end



  it 'saves a journey' do
    oystercard.top_up(10)
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard.journey_history).to include journey
  end
end
