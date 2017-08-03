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

    private

      def infer_type
        ## Given the @authoring_class, fill out what type of
        ## response this is (i.e., a cleaning, a validation, a
        ## translation... )
      end
  end
end
