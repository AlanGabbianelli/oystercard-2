require 'oystercard'
describe Oystercard do
let(:oystercard) { described_class.new }

  it 'has a balance' do
    expect(oystercard.balance).to eq(0)
  end

  it 'can be topped up' do
    oystercard.top_up(20)
    expect(oystercard.balance).to eq(20)
  end

  it 'has a maximum balance' do
    error = "Max balance: £#{Oystercard::MAX_BALANCE} reached"
    oystercard.top_up(50)
    expect { oystercard.top_up(1) }.to raise_error error
  end
end
