class Oystercard
  attr_reader :balance
  MAX_BALANCE = 50
  MIN_BALANCE = 0

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Max balance #{MAX_BALANCE} reached" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    fail "Cannot go below #{MIN_BALANCE}" if @balance - amount < MIN_BALANCE
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end
