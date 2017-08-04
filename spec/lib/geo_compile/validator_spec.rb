require "spec_helper"

RSpec.describe GeoCompile::Validator do
  let(:metadata) { '{ }' }

  describe '#valid?' do
    subject(:validator) { described_class.new(metadata, format) }

    context 'with a format that has no validator' do
      let(:format) { :not_implemented }

      it 'raises an error if the validation class is not implemented' do
        expect { validator.valid? }.to raise_error GeoCompile::Exceptions::ValidatorNotImplemented
      end
    end

    context 'with a format that has an implemented validator' do
      let(:format) { :GBL1_0 }

      it 'returns a boolean' do
        expect(validator.valid?).to be(true).or be(false)
      end
    end
  end

  describe '#errors' do
    subject(:validator) { described_class.new(metadata, format) }
    let(:format) { :GBL1_0 }

    it 'returns an array' do
      expect(validator.errors).to be_an(Array)
    end
  end
end
