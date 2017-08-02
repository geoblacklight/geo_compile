require "spec_helper"

RSpec.describe GeoCompile do
  describe '#translate' do
    subject { described_class }
    it 'has a translate method' do
      expect { subject.translate('metadata', :fgdc, :gbl) }.to raise_error GeoCompile::Exceptions::TranslationPathNotImplemented
    end
  end

  describe '#validate' do
    subject { described_class }
    it 'has a validate method' do
      expect(subject.validate('metadata', :fgdc))
    end
  end  
end
