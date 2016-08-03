require 'date'

module EcbRates
  class Application
    attr_reader :today, :history

    def initialize
      @today   = ExchangeRates.new(EcbRates::TODAY_RATES)
      @history = ExchangeRates.new(EcbRates::HISTORY_RATES)
    end

    def exchange_rate(currency, date = Date.today)
      fail DateTooOld           if date < Date.today - 90
      fail CurrencyMissing      unless currency
      fail CurrencyNotSupported unless
        EcbRates::VALID_CURRENCIES.include?(currency.to_sym)

      if date == Date.today
        @today.exchange_rate_for(currency, date)
      else
        @history.exchange_rate_for(currency, date)
      end
    end
  end
end
