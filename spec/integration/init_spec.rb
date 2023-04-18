RSpec.describe 'Gem usage' do
  it 'downloads' do
    RemoteInternationalization::Setup.call(adapter: :s3, host: 'localhost')
    # binding.pry
  end
end
