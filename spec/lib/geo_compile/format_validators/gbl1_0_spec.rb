require "spec_helper"

RSpec.describe GeoCompile::FormatValidators::GBL1_0 do
  let(:valid_metadata) { fixture('docs/full_geoblacklight.json') }
  let(:invalid_metadata) { fixture('docs/invalid_geoblacklight.json') }

  describe '#valid?' do
    context 'with a valid geoblacklight 1.0 document' do
      subject(:validator) { described_class.new(valid_metadata) }

      it 'returns true' do
        expect(validator.valid?).to be true
      end
    end

    context 'with an invalid geoblacklight 1.0 document' do
      subject(:validator) { described_class.new(invalid_metadata) }

      it 'returns false' do
        expect(validator.valid?).to be false
      end
    end
  end

  describe '#errors' do
    context 'with a valid geoblacklight 1.0 document' do
      subject(:validator) { described_class.new(valid_metadata) }

      it 'returns an empty array' do
        expect(validator.errors).to be_empty
      end
    end

    context 'with an invalid geoblacklight 1.0 document' do
      subject(:validator) { described_class.new(invalid_metadata) }

      it 'returns an array with three errors' do
        expect(validator.errors.count).to eq(3)
      end
    end
  end
end
