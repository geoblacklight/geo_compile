Dir.glob('lib/geo_compile/format_validators/**/*.rb').each { |file| require file.sub('lib/', '') }

module GeoCompile
  module FormatValidators
  end
end
