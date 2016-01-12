require 'oystercard'
describe Oystercard do
  let(:oystercard) { described_class.new }

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

  it 'can have money deducted' do
    oystercard.top_up(50)
    expect { oystercard.deduct(20) }.to change { oystercard.balance }.by(-20)
  end

  it 'cannot go below 0' do
    error = "Cannot go below #{Oystercard::MIN_BALANCE}"
    expect { oystercard.deduct(1) }.to raise_error error
  end
end
