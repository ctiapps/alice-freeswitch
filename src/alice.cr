require "./freeswitch/*"

module Alice
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}
end
