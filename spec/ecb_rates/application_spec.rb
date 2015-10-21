require 'spec_helper'
require 'timecop'

RSpec.describe EcbRates::Application do
  let(:app)      { EcbRates::Application.new }
  let(:currency) { EcbRates::VALID_CURRENCIES.first }

  describe 'exchange_rate' do
    before do
      Timecop.freeze('2015-10-19')
    end

    after do
      Timecop.return
    end

    context 'date == today' do
      it 'calls exchange_rate_for with current date and currency' do
        expect(app.today).to receive(:exchange_rate_for).
          with('JPY', Date.today)
        app.exchange_rate('JPY', Date.today)
      end
    end

    context 'date between yesterday and 90 days from now' do
      it 'calls exchange_rate_for with current date and currency' do
        expect(app.history).to receive(:exchange_rate_for).
          with('JPY', Date.today - 15)
        app.exchange_rate('JPY', Date.today - 15)
      end
    end

    context 'date older than 90 days from now' do
      it 'raises NotImplemented exception' do
        expect { app.exchange_rate('JPY', Date.today - 91) }.
          to raise_error EcbRates::Application::DateTooOld
      end
    end

    context 'date missing' do
      it "call exchange_rate_for with today's date and supplied currency" do
        expect(app.today).to receive(:exchange_rate_for).
          with('JPY', Date.today)
        app.exchange_rate('JPY')
      end
    end

    context 'currency_missing' do
      it 'raises CurrencyMissing exception' do
        expect { app.exchange_rate(nil) }.
          to raise_error EcbRates::Application::CurrencyMissing
      end
    end

    context 'currency not supported' do
      it 'raises CurrencyNotSupported exception' do
        expect { app.exchange_rate('IMAGINARY') }.
          to raise_error EcbRates::Application::CurrencyNotSupported
      end
    end
  end
end
