class Oystercard
  attr_reader :balance, :entry_station, :journey_history, :journey, :count
  MAX_BALANCE = 50
  MIN_LIMIT = 0
  MIN_CHARGE = 1

  def initialize
    @balance = 0
    @journey_history = {}
    @journey = {}
    @count = 0
  end

  def top_up(amount)
    fail "Max balance #{MAX_BALANCE} reached" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    @journey.length == 1 ? true : false
  end

  def touch_in(station)
    fail "Insuffient funds" if @balance < MIN_CHARGE
    journey[:entry_station] = station
  end

  def touch_out(station)
    deduct(MIN_CHARGE)
    journey[:exit_station] = station
    journey_history[:"journey#{count}"] = journey
    @count += 1
    @journey = {}
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
