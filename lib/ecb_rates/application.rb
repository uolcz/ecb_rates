require 'date'

module EcbRates
  class Application
    attr_reader :today, :history, :full_history

    def initialize
      @today   = ExchangeRates.new(EcbRates::TODAY_RATES)
      @history = ExchangeRates.new(EcbRates::HISTORY_RATES)
    end

    def exchange_rate(currency, date = Date.today)
      fail CurrencyMissing      unless currency
      fail CurrencyNotSupported unless EcbRates::VALID_CURRENCIES.include?(currency.to_sym)

      proper_source(date).exchange_rate_for(currency, date)
    end

    def proper_source(date)
      if date == Date.today
        @today
      elsif ((Date.today - 90)..Date.today).cover?(date)
        @history
      else
        @full_history = FullHistoryExchangeRates.new(EcbRates::FULL_HISTORY_RATES)
      end
    end
  end
end
