require 'ecb_rates/version'
require 'ecb_rates/application'
require 'ecb_rates/config'
require 'ecb_rates/exchange_rates'

module EcbRates
  $LOAD_PATH.unshift(File.dirname(__FILE__))

  def self.exchange_rate(currency, date = Date.today)
    app = Application.new
    app.exchange_rate(currency, date)
  end
end
