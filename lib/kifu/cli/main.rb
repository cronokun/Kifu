require 'thor'

module Kifu
  module CLI
    class Main < Thor

      desc 'info FILE', 'print basic game info'
      def info(file)
        parsed_data = Kifu::SgfReader.new(file).parse
        game        = Kifu::GameBuilder.new.build_from_sgf(parsed_data)
        printer     = Kifu::Printer.new(game)
        printer.print_info
        $stdout.puts printer.output
      end

    end
  end
end
