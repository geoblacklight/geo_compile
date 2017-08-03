module GeoCompile
  class TranslationResponse < Response
    def initialize(authoring_class, from, to)
      super(authoring_class)
      @input_format = from
      @output_format = to
    end

    def valid?
      true unless @errors.count > 0
    end
  end
end
