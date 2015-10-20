require 'date'

module EcbRates
  class Application
    class DateTooOld < StandardError; end
    class CurrencyMissing < StandardError; end
    class CurrencyNotSupported < StandardError; end

    attr_reader :today, :history

    def initialize
      @today   = ExchangeRates.new(EcbRates::TODAY_RATES)
      @history = ExchangeRates.new(EcbRates::HISTORY_RATES)
    end

    def exchange_rate(date = Date.today, currency)
      raise DateTooOld           if date < Date.today - 90
      raise CurrencyMissing      unless currency
      raise CurrencyNotSupported unless EcbRates::VALID_CURRENCIES.include?(currency.to_sym)

      if date == Date.today
        @today.exchange_rate_for(date, currency)
      else
        @history.exchange_rate_for(date, currency)
      end
    end
  end
end
