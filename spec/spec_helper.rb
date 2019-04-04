$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ecb_rates'
require 'rspec'

# source url:
#
# http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml
def load_today_fixture
  File.open('spec/fixtures/eurofxref-daily.xml')
end

# source url:
#
# http://www.ecb.europa.eu/stats/eurofxref/eurofxref-hist-90d.xml
def load_history_fixture
  File.open('spec/fixtures/eurofxref-hist-90d.xml')
end

# source url:
#
# https://www.ecb.europa.eu/stats/eurofxref/eurofxref-sdmx.xml
def load_full_history_fixture
  File.open('spec/fixtures/eurofxref-sdmx.xml')
end
