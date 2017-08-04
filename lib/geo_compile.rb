require 'nokogiri'
require 'json'
require 'json-schema'
require 'sanitize'

require 'geo_compile/exceptions'
require 'geo_compile/registry'
require 'geo_compile/translator'
require 'geo_compile/format_translators'
require 'geo_compile/format_validators'
require 'geo_compile/validator'

module GeoCompile
  def self.translate(metadata, from, to)
    translator = GeoCompile::Translator.new(from, to)
    translator.translate(metadata)
  end

  def self.validate(metadata, format)
    GeoCompile::Validator.new(metadata, format)
  end
end
