module GeoCompile
  module FormatTranslators
    class GBL1_0_to_GBL2_0

      def self.registration_entry
        { from: :GBL1_0 , to: :GBL2_0, class: GeoCompile::FormatTranslators::GBL1_0_to_GBL2_0 }
      end

      def translate(metadata)
      end

    end
  end
end

GeoCompile::FormatTranslators.REGISTRY < GeoCompile::FormatTranslators::GBL1_0_to_GBL2_0.registration_entry