require "redcarpet"

# Fix for redcarpet
class Tilt::RedcarpetTemplate

  def prepare
    klass = [Redcarpet2, Redcarpet1].detect { |e| e.engine_initialized? }
    @engine = klass.new(file, line, options) { data }
  end
    
end