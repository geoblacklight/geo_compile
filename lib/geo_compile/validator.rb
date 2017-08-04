module GeoCompile
  class Validator
    def initialize(metadata, format)
      @metadata = metadata
      @format = format
    end

    def valid?
      validator_class.new(@metadata).valid?
    end

    def errors
      validator_class.new(@metadata).errors
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
