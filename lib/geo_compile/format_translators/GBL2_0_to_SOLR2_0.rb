module GeoCompile
  module FormatTranslators
    class GBL2_0_to_SOLR2_0

      def self.registration_entry
        { from: :GBL2_0 , to: :SOLR2_0, class: GeoCompile::FormatTranslators::GBL2_0_to_SOLR2_0 }
      end

      def translate(metadata)
      end

    end
  end
end

GeoCompile::Registry::TRANSLATORS << GeoCompile::FormatTranslators::GBL2_0_to_SOLR2_0.registration_entry