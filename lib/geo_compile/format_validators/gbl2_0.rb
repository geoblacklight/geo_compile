module GeoCompile
  module FormatValidators
    class GBL2_0
      def self.registration_entry
        { format: :GBL2_0, class: GeoCompile::FormatValidators::GBL2_0 }
      end

      def initialize(metadata)
        @schema = JSON.parse(File.read('lib/geo_compile/schemas/geoblacklight/GBL2_0.json'))
        @metadata = metadata
      end

      def valid?
        JSON::Validator.validate!(@schema, @metadata, fragment: '#/definitions/dataset')
      rescue JSON::Schema::ValidationError
        return false
      end

      def errors
        JSON::Validator.fully_validate(@schema, @metadata, fragment: '#/definitions/dataset')
      end
    end
  end
end

GeoCompile::Registry::VALIDATORS << GeoCompile::FormatValidators::GBL2_0.registration_entry
