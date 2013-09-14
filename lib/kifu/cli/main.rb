module Kifu
  module CLI
    module Main

      def main
        if ARGV.empty?
          print_short_usage
          exit
        end

        command = ARGV.shift
        file = ARGV.shift

        case command
        when "info"
          parsed_data = Kifu::SgfReader.new(file).parse
          game        = Kifu::GameBuilder.new.build_from_sgf(parsed_data)
          printer     = Kifu::Printer.new(game)
          printer.print_info
          puts printer.output
        else
          print_short_usage
        end
      end

      private

      def print_short_usage
        puts "Usage: kifu command [arguments...] [options...]"
      end

    end
  end
end
