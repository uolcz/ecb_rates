require 'nokogiri'
require 'open-uri'

module EcbRates
  class ExchangeRates
    attr_reader :url

    def initialize(url)
      @url = url
    end

    def exchange_rate_for(currency, date)
      normalized_date = normalize_date(date)

      source ||= Nokogiri::XML(open(@url))

      return nil unless source.at_css("Cube[time='#{normalized_date}']")

      source.at_css("Cube[time='#{normalized_date}'] Cube[currency='#{currency}']").
        attr('rate').to_f
    end

    private

    def normalize_date(date)
      date.strftime('%Y-%m-%d')
    end
  end
end
