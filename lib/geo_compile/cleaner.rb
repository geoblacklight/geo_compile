module GeoCompile
  class Cleaner
    def initialize(format)
      @format = format
    end

    def clean(metadata)
      cleaner_class.new.clean(metadata)
    end

    def cleaner_class
      GeoCompile::Registry::CLEANERS.each do |r|
        return r[:class] if r[:format] == @format
      end

      raise GeoCompile::Exceptions::CleanerNotImplemented,
            "Cleaner for #{@format} not implemented."
    end
  end
end
