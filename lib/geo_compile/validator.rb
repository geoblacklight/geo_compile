module GeoCompile
  class Validator
    def initialize(format)
      @format = format
    end

    def validate(metadata)
      validator_class.new.validate(metadata)
    end

    def validator_class
      GeoCompile::Registry::VALIDATORS.each do |r|
        return r[:class] if r[:format] == @format
      end

      raise GeoCompile::Exceptions::ValidatorNotImplemented,
            "Validator for #{@format} not implemented."
    end
  end
end
