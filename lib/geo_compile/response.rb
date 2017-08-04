module GeoCompile
  class Response
    def initialize(authoring_class)
      @authoring_class = authoring_class
      @warnings = []
      @errors = []
    end

    def log_warning(warning)
      @warnings << warning
    end

    def log_error(_error)
      @errors
    end

    def attach_data(data)
      @data = data
    end

    def data
      @data unless @errors.count > 0
    end

  end
end
