require 'nokogiri'
require 'open-uri'

module EcbRates
  class BaseExchangeRates
    attr_reader :source, :normalized_date, :currency, :url
    def initialize(url)
      @url = url
      @source ||= read_xml
    end

    def exchange_rate_for(currency, date)
      @normalized_date = normalize_date(date)
      @currency = currency

      fetch_exchange_rate
    end

    private

    def fetch_exchange_rate
      raise 'Implement in subclass'
    end

    def normalize_date(date)
      date.strftime('%Y-%m-%d')
    end

    def read_xml
      Nokogiri::XML(open(@url))
    end
  end

  class ExchangeRates < BaseExchangeRates
    private

    def fetch_exchange_rate
      return nil unless @source.at_css("Cube[time='#{@normalized_date}']")

      @source.at_css("Cube[time='#{@normalized_date}'] Cube[currency='#{currency}']").
        attr('rate').to_f
    end
  end

  class FullHistoryExchangeRates < BaseExchangeRates
    class Parser < Nokogiri::XML::SAX::Document
      attr_reader :result

      def initialize(date)
        @date = date
        @result = nil
      end

      def start_element(name, attrs = [])
        hsh = attrs.to_h
        if name == 'Obs' && hsh['TIME_PERIOD'] == @date
          @result = hsh['OBS_VALUE'].to_f
        end
      end
    end

    private

    def fetch_exchange_rate
      parser = Parser.new(normalized_date)

      source.each do |node|
        if node.name == 'Series' && node.attributes['CURRENCY'] == currency
          Nokogiri::XML::SAX::Parser.new(parser).parse(node.outer_xml)

        end
      end

      parser.result
    end

    def read_xml
      Nokogiri::XML::Reader(open(@url))
    end
  end
end
