module GeoCompile
  module FormatTranslators
    class GBL1_0_to_GBL2_0
      def self.registration_entry
        { from: :GBL1_0, to: :GBL2_0, class: GeoCompile::FormatTranslators::GBL1_0_to_GBL2_0 }
      end

      def translate(metadata)
        build_record(JSON.parse(metadata))
      end

      private

      def build_record(record)
        ## Note: this is a LOSSY transform from GBL 1.0 -> 2.0 DCAT
        ## TODO: array / multivalue checking
        ## TODO: simple conversions of datetime to ISO 8601 (no '/' for separation of date components)

        dcat_record = {}
        dcat_record[:@context] = "https://raw.githubusercontent.com/geoblacklight/geoblacklight-schema/json-ld-schema/v2/schema/context.jsonld"
        dcat_record[:@id] = record.fetch('dc_identifier_s', nil)
        dcat_record[:@type] = "dcat:Dataset"
        dcat_record[:accessLevel] = normalize_access_string(record.fetch('dc_rights_s', nil))
        dcat_record[:conformsTo] = "https://raw.githubusercontent.com/geoblacklight/geoblacklight/master/schema/v2.0/geoblacklight-schema.json"
        dcat_record[:creator] = record.fetch('dc_creator_sm', nil)
        dcat_record[:description] = record.fetch('dc_description_s', nil)
        dcat_record[:distribution] = []
        dcat_record[:geom] = record.fetch('solr_geom', nil)
        dcat_record[:geomType] = record.fetch('layer_geom_type_s', nil)
        dcat_record[:isPartOf] = record.fetch('dct_isPartOf_sm', nil)
        dcat_record[:issued] = record.fetch('dct_issued_s', nil)
        dcat_record[:landingPage] = nil
        dcat_record[:language] = normalize_language_string(record.fetch('dc_language_s', nil))
        dcat_record[:license] = nil
        dcat_record[:modified] = record.fetch('layer_modified_dt', nil)
        dcat_record[:provenance] = record.fetch('dct_provenance_s', nil)
        dcat_record[:publisher] = [record.fetch('dc_publisher_s', nil)]
        dcat_record[:resourceType] = record.fetch('dc_type_s', nil)
        dcat_record[:rights] = nil
        dcat_record[:slug] = record.fetch('layer_slug_s', nil)
        dcat_record[:source] = record.fetch('dc_source_sm', nil)
        dcat_record[:spatial] = record.fetch('dct_spatial_sm', nil)
        dcat_record[:subject] = record.fetch('dc_subject_sm', nil)
        dcat_record[:temporal] = record.fetch('dct_temporal_sm', nil)
        dcat_record[:title] = record.fetch('dc_title_s', nil)

        parsed_references = JSON.parse(record['dct_references_s'])

        parsed_references.each do |k,v|
          case k
            when "http://schema.org/downloadUrl" ## Direct-download URL
              dcat_record[:distribution] << generate_distribution_download(record['dc_format_s'], record['dc_format_s'], "application/octet-stream", v)
            when "http://schema.org/url" ## URL
              dcat_record[:landingPage] = v
            when "http://www.opengis.net/cat/csw/csdgm" ## FGDC metadata
              dcat_record[:distribution] << generate_distribution_download("FGDC Metadata", "FGDC", "application/xml", v, k)
            when "http://www.w3.org/1999/xhtml" ## HTML metadata
              dcat_record[:distribution] << generate_distribution_download("HTML Metadata", "HTML", "application/html", v, k)
            when "http://iiif.io/api/image" ## IIIF image
              dcat_record[:distribution] << generate_distribution_service(v, k, nil, ["JPG"])
            when "http://iiif.io/api/presentation#manifest" ## IIIF manifest
              dcat_record[:distribution] << generate_distribution_service(v, k)
            when "http://www.isotc211.org/schemas/2005/gmd/" ## ISO 19139 metadata
              dcat_record[:distribution] << generate_distribution_download("ISO 19139 Metadata", "ISO19139", "application/xml", v, k)
            when "http://www.loc.gov/mods/v3" ## MODS metadata
              dcat_record[:distribution] << generate_distribution_download("MODS Metadata", "MODS", "application/mods+xml", v, k)
            when "http://www.esri.com/library/whitepapers/pdfs/shapefile.pdf" ## Shapefile (download?)
              dcat_record[:distribution] << generate_distribution_download("Shapefile", "Shapefile", "application/octet-stream", v, k)
            when "http://www.opengis.net/def/serviceType/ogc/wcs" ## WCS web service
              dcat_record[:distribution] << generate_distribution_service(v, k, record['layer_id_s'], [])
            when "http://www.opengis.net/def/serviceType/ogc/wfs" ## WFS web service
              dcat_record[:distribution] << generate_distribution_service(v, k, record['layer_id_s'], downloadable_formats(record['dc_format_s'],k))
            when "http://www.opengis.net/def/serviceType/ogc/wms" ## WMS web service
              dcat_record[:distribution] << generate_distribution_service(v, k, record['layer_id_s'], downloadable_formats(record['dc_format_s'],k))
            when "http://schema.org/DownloadAction" ## Harvard downloader
              dcat_record[:distribution] << generate_distribution_service(v, k, record['layer_id_s'])
            ## when "http://schema.org/UserDownloads" ## (Is this being used?)
            when "urn:x-esri:serviceType:ArcGIS#FeatureLayer" ## ESRI feature layer
              dcat_record[:distribution] << generate_distribution_service(v, k)
            when "urn:x-esri:serviceType:ArcGIS#TiledMapLayer"
              dcat_record[:distribution] << generate_distribution_service(v, k)
            when "urn:x-esri:serviceType:ArcGIS#DynamicMapLayer"
              dcat_record[:distribution] << generate_distribution_service(v, k)
            when "urn:x-esri:serviceType:ArcGIS#ImageMapLayer"
              dcat_record[:distribution] << generate_distribution_service(v, k)
            when "http://lccn.loc.gov/sh85035852" ## Data dictionary / codebook
              dcat_record[:describedBy] = v
            else
              puts "** Unknown key: #{k} **"
          end
        end

        dcat_record.delete_if { |k, v| v.nil? }
      end

      ##
      # Create default download types given a web service URI (contingent on format field)
      # @param [String, String]
      # @return [Array<String>]
      def downloadable_formats(dc_format_s, webservice_uri)
        case dc_format_s
          when "Shapefile"
            return ["KMZ"] if webservice_uri == "http://www.opengis.net/def/serviceType/ogc/wms"
            return ["Shapefile", "GeoJSON"] if webservice_uri == "http://www.opengis.net/def/serviceType/ogc/wfs"
          when "GeoTIFF", "ArcGRID"
            return ["GeoTIFF"] if webservice_uri == "http://www.opengis.net/def/serviceType/ogc/wms"
        end
        []
      end

      ##
      # Create dcat:distribution object for a download
      # @param [String,String,String,String,String]
      # @return [Hash]
      def generate_distribution_download(title,format,media_type,value,conforms_to = nil)
        {
            :@type => 'dcat:Distribution',
            conformsTo: conforms_to,
            downloadURL: value,
            format: [format],
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

      def normalize_access_string(access)
        return 'public' unless access
        case access.downcase
          when 'public'
            'public'
          when 'restricted'
            'restricted'
          else
            'public'
        end
      end

      def normalize_language_string(lang)
        return ['English'] unless lang
        [lang]
      end

    end
  end
end

GeoCompile::Registry::TRANSLATORS << GeoCompile::FormatTranslators::GBL1_0_to_GBL2_0.registration_entry
