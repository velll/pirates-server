class Fleet
  class << self
    OPTIONS = %w[pirates spaniards]

    def enemy_of(fleet)
      OPTIONS.find { |f| f != fleet }
    end

    def known?(fleet)
      OPTIONS.include? fleet
    end
  end
end
