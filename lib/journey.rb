class Journey
  attr_reader :entry_station, :exit_station, :history, :count

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @history = {}
    @count = 1
  end

  def end_at(exit_station = nil)
    @exit_station = exit_station
    history[:"journey#{count}"] = self
    @count += 1
  end

  def fare
    complete? ? MIN_FARE : PENALTY_FARE
  end

  private

  def complete?
    entry_station && exit_station
  end
end
