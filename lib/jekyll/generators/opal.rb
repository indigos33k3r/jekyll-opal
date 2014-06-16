require 'opal'

module Jekyll
  module Generators
    class Opal < Generator

      OPAL_LOCATION = File.join("js", "opal.js").freeze

      def generate(site)
        write_file output_location(site)
        (site.keep_files ||= []) << OPAL_LOCATION
      end

      def write_file(location)
        ensure_directory(location)
        File.open(location, 'wb') do |f|
          f.puts(opal_stdlib)
        end
        location
      end

      def opal_stdlib
        ::Opal::Builder.build('opal')
      end

      def ensure_directory(location)
        dir = File.dirname(location)
        unless File.directory?(dir)
          require 'fileutils'
          FileUtils.mkdir_p(dir)
        end
      end

      def output_location(site)
        File.expand_path(OPAL_LOCATION, site.dest)
      end

    end
  end
end