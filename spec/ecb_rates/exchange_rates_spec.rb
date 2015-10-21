require 'spec_helper'
require 'webmock/rspec'
require 'timecop'

RSpec.describe EcbRates::ExchangeRates do
  let(:today_rates)   { EcbRates::ExchangeRates.new(EcbRates::TODAY_RATES) }
  let(:history_rates) { EcbRates::ExchangeRates.new(EcbRates::HISTORY_RATES) }

  describe '#initialize' do
    context 'today' do
      it 'sets exchange rates today url' do
        expect(today_rates.url).to eq(EcbRates::TODAY_RATES)
      end
    end

    context 'history' do
      it 'sets exchange rates history url' do
        expect(history_rates.url).to eq(EcbRates::HISTORY_RATES)
      end
    end
  end

  describe '#exchange_rate_for' do
    before do
      stub_request(:get, (EcbRates::TODAY_RATES)).
        to_return(status: 200, body: load_today_fixture)

      stub_request(:get, (EcbRates::HISTORY_RATES)).
        to_return(status: 200, body: load_history_fixture)

      Timecop.freeze('2015-10-19')
    end

    after do
      Timecop.return
    end

    context 'today' do
      it 'returns exchange rate' do
        expect(today_rates.exchange_rate_for('JPY', Date.today)).to eq(135.29)
      end

      it 'returns nil if exchange rates arent present for particular date' do
        expect(today_rates.exchange_rate_for('JPY', Date.today + 1)).to eq(nil)
      end
    end

    context 'history' do
      it 'returns exchange rate' do
        expect(history_rates.exchange_rate_for('JPY', Date.today - 11)).
          to eq(134.92)
      end

      it 'returns nil if exchange rates arent present for particular date' do
        expect(history_rates.exchange_rate_for('JPY', Date.today + 1)).
          to eq(nil)
      end
    end
  end

  def load_today_fixture
    File.open('spec/fixtures/eurofxref-daily.xml')
  end

  def load_history_fixture
    File.open('spec/fixtures/eurofxref-hist-90d.xml')
  end
end
