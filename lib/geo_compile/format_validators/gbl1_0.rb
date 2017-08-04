module GeoCompile
  module FormatValidators
    class GBL1_0
      def self.registration_entry
        { format: :GBL1_0, class: GeoCompile::FormatValidators::GBL1_0 }
      end

      def initialize(metadata)
        @schema = JSON.parse(File.read('lib/geo_compile/schemas/geoblacklight/GBL1_0.json'))
        @metadata = metadata
      end

      def valid?
        JSON::Validator.validate!(@schema, @metadata, fragment: '#/definitions/layer')
      rescue JSON::Schema::ValidationError
        return false
      end

      def errors
        JSON::Validator.fully_validate(@schema, @metadata, fragment: '#/definitions/layer')
      end
    end
  end
end

GeoCompile::Registry::VALIDATORS << GeoCompile::FormatValidators::GBL1_0.registration_entry
