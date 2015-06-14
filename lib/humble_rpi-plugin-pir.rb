#!/usr/bin/env ruby

# file: humble_rpi-plugin-pir.rb

require 'chronic_duration'
require 'pi_piper'


class HumbleRPiPluginPir
  include PiPiper

  def initialize(settings: {}, variables: {})

    @pins = settings[:pins]
    @duration = settings[:duration] || '1 minute'
    @notifier = variables[:notifier]
    @device_id = variables[:device_id] || 'pi'
      
    at_exit do
      
      @pins.each do |pin|

        uexp = open("/sys/class/gpio/unexport", "w")
        uexp.write(pin)
        uexp.close
      
      end
    end

    
  end

  def start()

    count = 0
    
    duration = @duration
    notifier = @notifier
    device_id = @device_id
    
    t1 = Time.now - (ChronicDuration.parse(duration) + 10)    
    
    puts 'ready to detect motion'
    
    @pins.each.with_index do |pin, i|

      after pin: pin.to_i, goes: :high do
        
        count += 1

        if Time.now > t1 + ChronicDuration.parse(duration)  then

          notifier.notice "%s/motion/%s: detected %s times within the past %s" \
                                            % [device_id, i, count, duration]
          t1 = Time.now
          count = 0
        end

      end
    end
    
    PiPiper.wait
    
  end
  
  alias on_start start
  
  
end