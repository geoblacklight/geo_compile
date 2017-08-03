module GeoCompile
  class ValidationResponse < Response
    def initialize(authoring_class)
      super(authoring_class)
    end

    def valid?
      true unless @errors.count > 0
    end
  end
end
