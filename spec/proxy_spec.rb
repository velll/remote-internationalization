RSpec.describe RemoteInternationalization do
  before(:all) do
    RemoteInternationalization::Setup.call(
      adapter: :s3,
      host: 'localhost',
      fallback_path: 'spec/examples/local/'
    )

    RemoteInternationalization::Initialize.call
  end

  it 'translates' do
    expect(described_class.t(:hello)).to eq('Hello World')
  end

  it 'allows the choice of a locale' do
    described_class.with_locale(:de) do
      expect(described_class.t(:hello)).to eq('Hallo Welt')
    end
  end
end
