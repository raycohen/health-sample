Geocoder.configure(
  # Geocoding options
  # timeout: 5,                 # geocoding service timeout (secs)
  # language: :en,              # ISO-639 language code
  # http_proxy: nil,            # HTTP proxy server (user:pass@host:port)
  # https_proxy: nil,           # HTTPS proxy server (user:pass@host:port)

  use_https: true,           # use HTTPS for lookup requests? (if supported)
  lookup: :bing,
  api_key: 'AoI2-FwWmxcxXwugqjm27XCReMcteV7o7wlXL85EYnbmA9aqqO4oni6NDYsFHwC2',

  # cache: nil,                 # cache object (must respond to #[], #[]=, and #keys)
  # cache_prefix: 'geocoder:',  # prefix (string) to use for all cache keys

  # Exceptions that should not be rescued by default
  # (if you want to implement custom error handling);
  # supports SocketError and Timeout::Error
  # always_raise: [Timeout::Error],

  # Calculation options
  # units: :mi,                 # :km for kilometers or :mi for miles
  # distances: :linear          # :spherical or :linear
)
