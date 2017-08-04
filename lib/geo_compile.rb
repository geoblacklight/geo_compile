require 'nokogiri'
require 'json'
require 'json-schema'
require 'sanitize'

require 'geo_compile/exceptions'
require 'geo_compile/response'
require 'geo_compile/validation_response.rb'
require 'geo_compile/translation_response.rb'
require 'geo_compile/registry'
require 'geo_compile/translator'
require 'geo_compile/cleaner'
require 'geo_compile/format_translators'
require 'geo_compile/format_validators'
require 'geo_compile/format_cleaners'
require 'geo_compile/validator'

module GeoCompile
  def self.translate(metadata, from, to)
    translator = GeoCompile::Translator.new(from, to)
    translator.translate(metadata)
  end

  def self.validate(metadata, format)
    validator = GeoCompile::Validator.new(format)
    validator.validate(metadata)
  end

  def self.clean(metadata, format)
    cleaner = GeoCompile::Cleaner.new(format)
    cleaner.clean(metadata)
  end
end
