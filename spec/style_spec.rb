# rubocop: disable Layout/LineLength
require_relative '../lib/style_rules'

describe StyleRules do
  let(:file) { StyleRules.new }
  let(:wrong_color) { ['#Fff;'] }
  let(:right_color) { ['#fff;'] }
  let(:wrong_indent) { ['.test {', 'background: blue;', '}'] }
  let(:right_indent) { ['.test {', '  background: blue;', '}'] }
  let(:right_brace) { ['.test {', '  background: blue;', '}'] }
  let(:wrong_brace) { ['.test{', '  background: blue;', '}'] }
  let(:right_block) { ['.test {', '  background: blue;', '}'] }
  let(:no_unit) { ['.test {', '  background: blue;', '  padding-top: 0;', '}'] }
  let(:unit) { ['.test {', '  background: blue;', '  padding-top: 0rem;', '}'] }
  let(:wrong_block) { ['.test {}'] }
  let(:error) { [] }

  describe '#lower_case_color' do
    context 'when an hex code is used' do
      it 'returns an error message with line number when the hex code is uppercase' do
        expect(file.lower_case_color(wrong_color, error)).to eql(['On line 1: Use lower case for hex color code'])
      end

      it 'returns no error message if the hex code is all in lower case' do
        expect(file.lower_case_color(right_color, error)).to_not eql(['On line 1: Use lower case for hex color code'])
      end
    end
  end

  describe '#indentation_of_block' do
    context 'when there is a block of code' do
      it 'returns an error message with line number when the block is not properly indented' do
        expect(file.indentation_of_block(wrong_indent, error)).to eql(['On line 2: Indentation of 2 spaces required'])
      end

      it 'returns no error message if the block is properly indented' do
        expect(file.indentation_of_block(right_indent, error)).to_not eql(['On line 2: Indentation of 2 spaces required'])
      end

      it 'returns no error message if the block is properly indented' do
        expect(file.indentation_of_block(right_indent, error)).to eql([])
      end
    end
  end

  describe 'opening_brace_space' do
    context 'when there is an opening brace' do
      it 'returns an error message with line number when there is no space before opening brace' do
        expect(file.opening_brace_space(wrong_brace, error)).to eql(['On line 1: Add a space before the opening brace'])
      end

      it 'returns no error message if the opening brace has a space' do
        expect(file.opening_brace_space(right_brace, error)).to eql([])
      end

      it 'returns an error message with line number when there is no space before opening brace' do
        expect(file.opening_brace_space(wrong_brace, error)).to_not eql([])
      end
    end
  end

  describe 'empty_block' do
    context 'when there is a block' do
      it 'returns an error message with line number when the block is empty' do
        expect(file.empty_block(wrong_block, error)).to eql(['On line 1: Block is empty'])
      end

      it 'returns no error message if the block is not empty' do
        expect(file.empty_block(right_block, error)).to eql([])
      end

      it 'returns an error message with line number when the block is empty' do
        expect(file.empty_block(wrong_block, error)).to_not eql([])
      end
    end
  end

  describe 'no_unit_for_zero' do
    context 'when there is a unit for 0' do
      it 'returns an error message with line number when a unit is given to 0' do
        expect(file.no_unit_for_zero(unit, error)).to eql(['On line 3: No unit required if value is Zero'])
      end

      it 'returns no error message if no unit is given to 0' do
        expect(file.no_unit_for_zero(no_unit, error)).to eql([])
      end

      it 'returns an error message with line number when a unit is given to 0' do
        expect(file.no_unit_for_zero(unit, error)).to_not eql([])
      end
    end
  end
end
# rubocop: enable Layout/LineLength
