Dir.glob('lib/geo_compile/format_cleaners/**/*.rb').each { |file| require file.sub('lib/', '') }

module GeoCompile
  module FormatCleaners
  end
end
