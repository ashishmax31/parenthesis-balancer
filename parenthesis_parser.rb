class String
  def opening_character?
    ['{', '[', '('].include?(self)
  end

  def closing_character?
    ['}', ']', ')'].include?(self)
  end

  def matching_brackets?(bracket)
    matching_pairs = {'('=> ')', '{' => '}', '[' => ']'}
    matching_pairs[bracket] == self
  end
end


class ParenthesisParser
  attr_accessor :debug, :args, :input

  SUPPORTED_BRACKETS = ['{','}', '[', ']', '(', ')']

  def initialize(input, debug = false)
    @input = input
    @debug = debug
    @args = []
  end

  def parse
    self.args = input.gsub(/\s+/, "").split("")
                 .select{|char| SUPPORTED_BRACKETS.include?(char)}
    if self.args.empty?
      raise 'No paranthesis given'
    end
  end

  def balanced?
    self.parse
    return false if (args.length % 2 != 0)

    stack = []
    args.map do |arg|
      # Push element into the stack if its an opening character.
      if arg.opening_character?
        stack.push(arg)
        true
      else
        ParenthesisParser.log("comparing #{stack.last} with #{arg}") if debug
        # Compare the closing character with last opening character seen.
        arg.matching_brackets?(stack.pop)
      end
    end.all?
  end

  def self.log(info)
    STDERR.puts(info)
  end
end



