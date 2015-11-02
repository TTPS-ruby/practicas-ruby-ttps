class DayChecker
  DAYS = {
    'domingo' => 0,
    'lunes' => 1,
    'martes' => 2,
    'miercoles' => 3,
    'jueves' => 4,
    'viernes' => 5,
    'sabado' => 6
  }.freeze

  def self.is?(date, expected_day = nil)
    expected_day = sanitize(expected_day || 5)
    date.wday == expected_day ? 'Si' : 'No'
  end

  def self.sanitize(day)
    if day.to_s =~ /^\d+$/
      day.to_i % 7
    elsif DAYS.keys.include?(day)
      DAYS[day]
    else
      raise "Invalid day provided: '#{day}'."
    end
  end
end
