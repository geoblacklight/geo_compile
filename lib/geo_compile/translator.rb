module GeoCompile
  class Translator
    def initialize(to, from)
      @to = to
      @from = from
    end

    def translate(metadata)
      translator_class.new.translate(metadata)
    end

    def translator_class
      begin
        Object.const_get("GeoCompile::Translators::#{@to}_#{@from}")
      rescue NameError
        raise GeoCompile::Exceptions::TranslationPathNotImplemented,
           "Translation from: #{@from}, to: #{@to} not implemented."
      end
    end
  end
end
