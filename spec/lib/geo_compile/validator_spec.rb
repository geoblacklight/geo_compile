require "spec_helper"

RSpec.describe GeoCompile::Validator do
  describe '#validate' do
    let(:format) { nil }
    let(:metadata) { { } }

    subject { described_class.new(format) }

    it 'has a validate method' do
      expect(subject.validate(metadata)).to be_nil
    end
  end
end
