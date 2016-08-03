[![Build Status](https://travis-ci.org/ucetnictvi-on-line/ecb_rates.svg)](https://travis-ci.org/ucetnictvi-on-line/ico-validator)
[![Dependency Status](https://gemnasium.com/ucetnictvi-on-line/ecb_rates.svg)](https://gemnasium.com/ucetnictvi-on-line/ecb_rates)
[![Inline docs](http://inch-ci.org/github/ucetnictvi-on-line/ecb_rates.svg?branch=master)](http://inch-ci.org/github/ucetnictvi-on-line/ecb_rates)
[![Code Climate](https://codeclimate.com/github/ucetnictvi-on-line/ecb_rates/badges/gpa.svg)](https://codeclimate.com/github/ucetnictvi-on-line/ecb_rates)
[![Test Coverage](https://codeclimate.com/github/ucetnictvi-on-line/ecb_rates/badges/coverage.svg)](https://codeclimate.com/github/ucetnictvi-on-line/ecb_rates)

# EcbRates:

Simple gem for getting exchange rates between EUR and various other currencies. Exchange rates are taken from European Central Bank (ECB).

## Installation

Install by `gem install ecb_rates` or add `gem 'ecb_rates'` to your Gemfile.

## Usage

```ruby
EcbRates.exchange_rate('JPY', Date.today)
```

Returns today's exchange rate between EUR and JPY. Input date
defaults to `Date.today`, so the above line can written like this:

```ruby
EcbRates.exchange_rate('JPY')
```

If there is no available exchange rate, the method returns *nil*.

## Exchange rate source

All exchange rates are taken from European Central Bank,
[http://www.ecb.europa.eu/stats/exchange/eurofxref/html/index.en.html].

### Exceptions
* `DateTooOld` – raised when the date entered is older than 90 days.
* `CurrencyMissing` – raised when a currency is not present.
* `CurrencyNotSupported` – raised when a currency is not on the list of supported
currencies.
