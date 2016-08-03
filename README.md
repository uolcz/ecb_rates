[![Build Status](https://travis-ci.org/ucetnictvi-on-line/ecb_rates.svg)](https://travis-ci.org/ucetnictvi-on-line/ico-validator)
[![Code Climate](https://codeclimate.com/github/ucetnictvi-on-line/ecb_rates/badges/gpa.svg)](https://codeclimate.com/github/ucetnictvi-on-line/ecb_rates)
[![Inline docs](http://inch-ci.org/github/ucetnictvi-on-line/ecb_rates.svg?branch=master)](http://inch-ci.org/github/ucetnictvi-on-line/ecb_rates)

# EcbRates:

Simple gem for getting exchange rates between from EUR to various other currencies.
Exchange rates are taken from ECB.

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
EcbRates.exchange_rate('JPY', Date.today)
```

Returns today's exchange rate between EUR and JPY.

Input date defaults to *Date.today* so the above line can written like this:

```ruby
EcbRates.exchange_rate('JPY')
```

If theres no available exchange rate, method returns *nil*.

## Exchange rate source

All exchange rates are taken from [http://www.ecb.europa.eu/stats/exchange/eurofxref/html/index.en.html]

### Exceptions
* `DateTooOld` - raised when the date entered is older than 90 days.
* `CurrencyMissing` - raised when a currency is not present.
* `CurrencyNotSupported` - raised when a currency is not on the list of supported
currencies.
