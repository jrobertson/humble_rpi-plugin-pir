# Introducing the Humble_rpi-plugin-pir gem


## Set up an SPS broker

    require 'simplepubsub'

    SimplePubSub::Broker.start(host: 'localhost', port: 59000)

## Test the SPS messaging is working

### Set up a subscriber

    require 'sps-sub'

    sps = SPSSub.new address: 'localhost', port: 59000

    def sps.ontopic(topic, msg)
      puts "%s - %s: %s"  % [Time.now.to_s, topic, msg.inspect]
    end

    sps.subscribe topic: '#'

### Publish a message

    require 'sps-pub'

    sps = SPSPub.new address: 'localhost', port: 59000
    sps.notice 'test: 123'


## Testing the plugin

    require 'sps-pub'
    require 'humble_rpi-plugin-pir'

    sps = SPSPub.new address: 'localhost', port: 59000
    rpi = HumbleRPiPluginPir.new(settings: {pins: [17, 27], \
                  duration: '10 seconds'}, variables: {notifier: sps})
    rpi.start

Observed <pre>2015-06-13 21:06:45 +0100 - pi/motion: "detected 4 times within the past 10 seconds"</pre>


## Resources

* ?humble_rpi-plugin-pir https://rubygems.org/gems/humble_rpi-plugin-pir?
* ?humble_rpi https://rubygems.org/gems/humble_rpi?

humblerpi plugin pir
