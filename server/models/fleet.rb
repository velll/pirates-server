class Fleet
  class << self
    def options
      %w[pirates spaniards]
    end

    def enemy_of(fleet)
      options.find { |f| f != fleet }
    end
  end
end
