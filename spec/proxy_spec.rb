RSpec.describe RemoteInternationalization do
  subject(:instance) { RemoteInternationalization.new }

  it 'translates' do
    expect(instance.t(:hello)).to eq('Hello World')
  end

  it 'allows the choice of a locale' do
    instance.with_locale(:de) do
      expect(instance.t(:hello)).to eq('Hallo Welt')
    end
  end
end
