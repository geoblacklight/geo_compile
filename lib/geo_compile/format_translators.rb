Dir.glob('lib/geo_compile/format_translators/**/*.rb').each { |file| require file.sub('lib/', '') }

module GeoCompile
  module FormatTranslators
  end
end
