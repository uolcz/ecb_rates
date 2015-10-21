

# EcbRates:

Simple gem for getting exchange rates between from EUR to various other currencies.

## Installation

Add following into your Gemfile

```ruby
gem 'ecb_rates'
```

Or install the gem directly

```
gem install ecb_rates
```

## Usage

```ruby
app = EcbRates::Application.new

app.exchange_rate('JPY', Date.today)
```

Returns exchange today's exchange rate between EUR and JPY.

Input date defaults to *Date.today* so the above line can written like this:

```ruby
app.exchange_rate('JPY')
```

If theres no available exchange rate, method returns *nil*.

## Exchange rate source

All exchange rates are taken from [http://www.ecb.europa.eu/stats/exchange/eurofxref/html/index.en.html]

### Exceptions
* DateTooOld - triggers when date entered is older than 90 days.
* CurrencyMissing - triggers when currency is not present.
* CurrencyNotSupported - triggers when currency is not in list of supported
currencies.
