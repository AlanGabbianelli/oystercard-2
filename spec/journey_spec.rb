require 'journey'

describe Journey do
  let(:journey) { described_class.new(entry_station) }
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  it 'starts with an entry station' do
    expect(journey.entry_station).to eq entry_station
  end

  it 'can have an exit station' do
    journey.end_at(exit_station)
    expect(journey.exit_station).to eq exit_station
  end

  it 'returns minimum fare if it is complete' do
    journey.end_at(exit_station)
    expect(journey.fare).to eq Journey::MIN_FARE
  end

  it 'returns penalty fare if it is incomplete' do
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  it 'stores a history of journeys' do
    journey.end_at(exit_station)
    expect(journey.history).to eq({ journey1: journey })
  end
end
