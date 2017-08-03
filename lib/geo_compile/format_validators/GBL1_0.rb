module GeoCompile
  module FormatValidators
    class GBL1_0
      def self.registration_entry
        { format: :GBL1_0, class: GeoCompile::FormatValidators::GBL1_0 }
      end

      def validate(metadata)
        @metadata = metadata
        @schema = JSON.parse(File.read('lib/geo_compile/schemas/geoblacklight/GBL1_0.json'))
        @response = GeoCompile::ValidationResponse.new(GeoCompile::FormatValidators::GBL1_0)
        @response.attach_data(metadata)

        ## Not actually implemented!
        ## @todo: Need to get JSON::Validator working here...

        @response
      end

      private

        def verify_enum_entries(authority, given_values)
          ## Add warnings if not part of controlled vocabulary
          ## Should not cause the validation to fail, just to have warning(s)
        end
    end
  end
end

GeoCompile::Registry::VALIDATORS << GeoCompile::FormatValidators::GBL1_0.registration_entry
