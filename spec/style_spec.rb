require_relative '../lib/style_rules'

describe StyleRules do
  let(:file) { StyleRules.new }
  let(:wrong_color) { ['#Fff;'] }
	let(:right_color) { ['#fff;'] }
	let(:wrong_indent) { ['.test {','background: blue;', '}'] }
	let(:right_indent) { ['.test {','  background: blue;', '}'] }
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
end