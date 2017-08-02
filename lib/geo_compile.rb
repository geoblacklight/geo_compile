require 'nokogiri'
require 'json'
require 'json-schema'
require 'sanitize'

require 'geo_compile/exceptions'
require 'geo_compile/translator'
require 'geo_compile/translators'
require 'geo_compile/validator'

module GeoCompile
  def self.translate(metadata, to, from)
    translator = GeoCompile::Translator.new(to, from)
    translator.translate(metadata)
  end

  def self.validate(metadata, format)
    validator = GeoCompile::Validator.new(format)
    validator.validate(metadata)
  end
end
