module Kifu
  module CLI
    class Output
      attr_reader :lines

      def initialize
        @lines = []
      end

      def puts(*strings)
        if strings.empty?
          lines << ''
        else
          lines.concat(strings)
        end
      end

      def output
        lines.join("\n")
      end

      alias_method :to_s, :output
    end
  end
end
