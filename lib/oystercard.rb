class Oystercard
attr_reader :balance
MAX_BALANCE = 50

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Max balance: £#{MAX_BALANCE} reached" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

end
