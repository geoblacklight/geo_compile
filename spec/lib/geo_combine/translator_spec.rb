require "spec_helper"

RSpec.describe GeoCompile::Translator do
  describe '#translate' do
    let(:from) { nil }
    let(:to) { nil }
    let(:metadata) { { } }

    subject { described_class.new(to, from) }

    it 'raises an error if the translation class is not implemented' do
      expect { subject.translate(metadata) }.to raise_error GeoCompile::Exceptions::TranslationPathNotImplemented
    end
  end
end
