require "spec_helper"

RSpec.describe GeoCompile::FormatValidators::GBL2_0 do
  let(:valid_metadata) { fixture('docs/gbl2_public_direct_download.jsonld') }
  let(:invalid_metadata) { fixture('docs/gbl2_invalid_public_direct_download.jsonld') }

  describe '#valid?' do
    context 'with a valid geoblacklight 2.0 document' do
      subject(:validator) { described_class.new(valid_metadata) }

      it 'returns true' do
        expect(validator.valid?).to be true
      end
    end

    context 'with an invalid geoblacklight 2.0 document' do
      subject(:validator) { described_class.new(invalid_metadata) }

      it 'returns false' do
        expect(validator.valid?).to be false
      end
    end
  end

  describe '#errors' do
    context 'with a valid geoblacklight 2.0 document' do
      subject(:validator) { described_class.new(valid_metadata) }

      it 'returns an empty array' do
        expect(validator.errors).to be_empty
      end
    end

    context 'with an invalid geoblacklight 2.0 document' do
      subject(:validator) { described_class.new(invalid_metadata) }

      it 'returns an array with three errors' do
        expect(validator.errors.count).to eq(1)
      end
    end
  end
end
