Dir["format_translators/*.rb"].each {|file| require file }

module GeoCompile
  module FormatTranslators
    REGISTRY = []
  end
end
