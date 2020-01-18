class Wind < Dry::Struct
  transform_keys(&:to_sym)

  attribute :bearing, Types::Symbol
  attribute :force, Types::Params::Integer

  BEARINGS = %i[N NE E SE S SW W NW]
  FORCE_ROLL_D = 6

  def self.generate
    new(bearing: BEARINGS.sample, force: rand(FORCE_ROLL_D))
  end
end
