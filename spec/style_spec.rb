require_relative '../lib/style_rules'

describe StyleRules do
  let(:file) { StyleRules.new }
  let(:wrong_color) { ['#Fff'] }
  let(:right_color) { ['#fff'] }
  let(:error) { [] }

  describe '#lower_case_color' do
    context 'when the hex color code is uppercase' do
      it 'returns an error message with line number' do
        expect(file.lower_case_color(wrong_color, error)).to eql(['On line 1: Use lower case for hex color code'])
      end
    end
  end

  describe '#lower_case_color' do
    context 'when the hex color code is lowercase' do
      it 'returns no error message' do
        expect(file.lower_case_color(right_color, error)).to_not eql(['On line 1: Use lower case for hex color code'])
      end
    end
  end
end
