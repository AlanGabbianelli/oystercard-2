require_relative 'journey'

class Oystercard
  attr_reader :balance, :journey
  MAX_BALANCE = 50
  MIN_LIMIT = 0

  def initialize(journey_klass = Journey)
    @balance = 0
    @journey = journey_klass
  end

  def top_up(amount)
    fail "Max balance #{MAX_BALANCE} reached" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    @journey = @journey.new(entry_station)
    fail 'Insuffient funds' if @balance < Journey::MIN_FARE
  end

  def touch_out(exit_station)
    journey.end_at(exit_station)
    deduct(@journey.fare)
    @journey = Journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
