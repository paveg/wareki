require 'date'
require 'wareki/date'
module Wareki
  # :nodoc:
  module StdExt
  end
end
# :nodoc:
class Date
  JAPAN = Wareki::GREGORIAN_START

  def to_wareki_date
    Wareki::Date.jd(jd)
  end

  alias _wareki_strftime_orig strftime
  def strftime(format = '%F')
    if format.index('%J')
      to_wareki_date.strftime(format)
    else
      _wareki_strftime_orig(format)
    end
  end

  class << self
    alias _wareki_parse_orig parse
    def parse(str, comp = true, start = ::Date::ITALY)
      Wareki::Date.parse(str).to_date(start)
    rescue ArgumentError, Wareki::UnsupportedDateRange
      ::Date._wareki_parse_orig(str, comp, start)
    end
  end
end
