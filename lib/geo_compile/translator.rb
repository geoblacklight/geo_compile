module GeoCompile
  class Translator
    def initialize(from, to)
      @from = from
      @to = to
    end

    def translate(metadata)
      translator_class.translate(metadata)
    end

    def translator_class
      begin
        Object.const_get("GeoCompile::Translators::#{@from}_to_#{@to}")
      rescue NameError
        raise GeoCompile::Exceptions::TranslationPathNotImplemented,
           "Translation from: #{@from}, to: #{@to} not implemented."
      end
    end
  end
end
