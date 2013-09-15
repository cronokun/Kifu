module Kifu
  module CLI
    class Output
      attr_reader :lines

      def initialize
        @lines = []
      end

      def puts(str = nil)
        lines << str
      end

      def output
        lines.join("\n")
      end

      alias_method :to_s, :output
    end
  end
end
