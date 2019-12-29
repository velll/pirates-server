class Fleet
  PIRATES = 'pirates'
  SPANIARDS = 'spaniards'
  OPTIONS = [SPANIARDS, PIRATES]

  class << self
    def enemy_of(fleet)
      OPTIONS.find { |f| f != fleet }
    end

    def known?(fleet)
      OPTIONS.include? fleet
    end
  end
end
