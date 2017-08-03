module GeoCompile
  class Translator
    def initialize(from, to)
      @from = from
      @to = to
    end

    def translate(metadata)
      translator_class.new.translate(metadata)
    end

    def translator_class
      GeoCompile::Registry::TRANSLATORS.each do |r|
        return r[:class] if r[:from] == @from && r[:to] == @to
      end

      raise GeoCompile::Exceptions::TranslationPathNotImplemented,
            "Translation from: #{@from}, to: #{@to} not implemented."
    end
  end
end
