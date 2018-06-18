require_relative 'parenthesis_parser'

parser = ParenthesisParser.new('')

loop do
  input = gets
  parser.input = input.chomp
  if parser.balanced?
    puts "Entered string has balanced parenthesis"
  else
    puts "Entered string does not have balanced parenthesis"
  end    
end