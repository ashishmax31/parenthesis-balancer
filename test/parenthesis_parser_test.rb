require_relative '../parenthesis_parser'
require 'test/unit'


class TestStringMethods < Test::Unit::TestCase
  def test_opening_parenthesis
    ['{', '(', '['].each do |char|
      assert char.opening_character?
    end
  end

  def test_closing_parenthesis
    [']', '}', ')'].each do |char|
      assert char.closing_character?
    end
  end

  def test_matching_brackets
    valid_set = [['(',')'], ['{', '}'], ['[', ']']]
    ['{', '[', '('].product([')', '}', ']']).each do |combination|
      assert_equal valid_set.include?(combination), combination.last.matching_brackets?(combination.first)
    end
  end
end


class TestParenthesisParser < Test::Unit::TestCase
  def setup
    @input = ParenthesisParser.new('')
    @test_inputs = ['()[]{}', '([{}])', '([]{})', '([)]', '([]', '[])', '([})']
  end

  def test_parsing
    @test_inputs.each do |str|
      @input.input = str
      @input.parse
      assert_equal @input.args, str.split('')
    end
  end

  def test_if_no_parenthesis_given
    @input.input = 'no parenthesis'
    assert_raise(RuntimeError, 'No paranthesis given') do
      @input.parse
    end
  end
  
  def test_if_string_is_balanced
    balanced_set = ['()[]{}', '([{}])', '([]{})']
    @test_inputs.each do |str|
      @input.input = str
      assert_equal @input.balanced?, balanced_set.include?(str)
    end
  end
end

