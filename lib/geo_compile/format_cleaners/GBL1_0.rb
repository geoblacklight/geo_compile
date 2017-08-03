module GeoCompile
  module FormatCleaners
    class GBL1_0
      def self.registration_entry
        { format: :GBL1_0, class: GeoCompile::FormatCleaners::GBL1_0 }
      end

      ## Conservative cleaning tasks:
      ## - alphabetize by key
      ## - normalize key names (case issues)
      ## - correct types (array, single value, string, etc)
      ##    - make type corrections where possible
      ## - domain specific cleaning
      ##    - correct ENVELOPE geometry to fit within 180, 90 if slightly over

      def clean(metadata)
        domain_specific(type_correct(normalize_keys(alphabetize_keys(metadata))))
      end

      protected

        def alphabetize_keys(metadata)
          ## Only in Ruby >= 2.1
          metadata.sort.to_h
        end

        def normalize_keys(metadata)
          metadata
        end

        def type_correct(metadata)
          metadata
        end

        def domain_specific(metadata)
          metadata
        end

      private

        def correct_geometry(geometry_string); end
    end
  end
end

GeoCompile::Registry::CLEANERS << GeoCompile::FormatCleaners::GBL1_0.registration_entry
