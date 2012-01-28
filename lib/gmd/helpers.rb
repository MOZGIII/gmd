require "date"

module Gmd
  module Helpers
  
    def date_and_time(format = "%d.%m.%Y %H:%M")
      DateTime.now.strftime(format)
    end
  
  end
end