module EcbRates
  TODAY_RATES   = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml'
  HISTORY_RATES = 'http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml'
  FULL_HISTORY_RATES = 'https://www.ecb.europa.eu/stats/eurofxref/eurofxref-sdmx.xml'

  VALID_CURRENCIES = [
    :USD, :JPY, :BGN, :CZK, :DKK, :GBP, :HUF, :PLN, :RON, :SEK, :CHF, :NOK,
    :HRK, :RUB, :TRY, :AUD, :BRL, :CAD, :CNY, :HKD, :IDR, :ILS, :INR, :KRW,
    :MXN, :MRY, :NZD, :PHP, :SGB, :THB, :ZAR
  ]
end
