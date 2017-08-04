module GeoCompile
  module FormatTranslators
    class GBL1_0_to_GBL2_0
      def self.registration_entry
        { from: :GBL1_0, to: :GBL2_0, class: GeoCompile::FormatTranslators::GBL1_0_to_GBL2_0 }
      end

      def translate(metadata); end

      private

      ##
      # Create dcat:distribution object for a download
      # @param [String,String,String,String,String]
      # @return [Hash]
      def generate_distribution_download(title,format,media_type,value,conforms_to = nil)
        {
            :@type => 'dcat:Distribution',
            conformsTo: conforms_to,
            downloadURL: value,
            format: format,
            mediaType: media_type,
            title: title
        }.delete_if { |k,v| v.nil? }
      end

      ##
      # Create dcat:distribution object for a web service
      # @param [String,String,String,String,String]
      # @return [Hash]
      def generate_distribution_service(value,conforms_to,layer_id = nil,downloadable_as = nil)
        {
            :@type => 'dcat:Distribution',
            accessURL: value,
            conformsTo: conforms_to,
            downloadableAs: downloadable_as,
            layerId: layer_id
        }.delete_if { |k,v| v.nil? }
      end
    end
  end
end

GeoCompile::Registry::TRANSLATORS << GeoCompile::FormatTranslators::GBL1_0_to_GBL2_0.registration_entry
