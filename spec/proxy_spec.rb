RSpec.describe RemoteInternationalization do
  before(:all) do
    setup_and_init!
  end

  it 'translates' do
    expect(described_class.t(:hello)).to eq('Hello World (from outside)')
  end

  it 'allows the choice of a locale' do
    described_class.with_locale(:de) do
      expect(described_class.t(:hello)).to eq('Hallo Welt (from outside)')
    end
  end

  it 'uses local translations for files that are not present on the remote' do
    expect(described_class.t(:exclusive)).to eq('Exclusively Local')
  end

  describe 'broken connection' do
    before do
      allow_any_instance_of(RemoteInternationalization::Adapters::S3).to receive(:get_object).and_return(nil)
      setup_and_init!
    end

    it 'translates using the fallback files' do
      expect(described_class.t(:hello)).to eq('Hello World')
    end

    it 'allows the choice of a locale (and uses fallback)' do
      described_class.with_locale(:de) do
        expect(described_class.t(:hello)).to eq('Hallo Welt')
      end
    end
  end
end
