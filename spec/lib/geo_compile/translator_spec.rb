require "spec_helper"

RSpec.describe GeoCompile::Translator do
  describe '#translate' do
    subject(:translator) { described_class.new(to, from) }
    let(:from) { nil }
    let(:to) { nil }
    let(:metadata) { {} }

    it 'raises an error if the translation class is not implemented' do
      expect { translator.translate(metadata) }.to raise_error GeoCompile::Exceptions::TranslationPathNotImplemented
    end
  end
end
