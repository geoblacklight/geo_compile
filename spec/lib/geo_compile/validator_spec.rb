require "spec_helper"

RSpec.describe GeoCompile::Validator do
  describe '#validate' do
    subject(:validator) { described_class.new(format) }
    let(:format) { nil }
    let(:metadata) { {} }

    it 'has a validate method' do
      expect(validator.validate(metadata)).to be_nil
    end
  end
end
