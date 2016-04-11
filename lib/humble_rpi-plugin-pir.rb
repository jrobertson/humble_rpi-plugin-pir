#!/usr/bin/env ruby

# file: humble_rpi-plugin-pir.rb


require 'rpi_pinin'
require 'chronic_duration'



class HumbleRPiPluginPir


  def initialize(settings: {}, variables: {})

    @pins = settings[:pins].map {|x| RPiPinIn.new x}
    @duration = settings[:duration] || '1 minute'
    @notifier = variables[:notifier]
    @device_id = variables[:device_id] || 'pi'
    
  end

  def start()

    count = 0
    
    duration = @duration
    notifier = @notifier
    device_id = @device_id
    
    t1 = Time.now - (ChronicDuration.parse(duration) + 10)    
    
    puts 'ready to detect motion'
        
    @pins.each.with_index do |pin, i|
            
      Thread.new do      
        
        pin.watch_high do
          
          count += 1

          if Time.now > t1 + ChronicDuration.parse(duration)  then

            notifier.notice \
                "%s/motion/%s: detected %s times within the past %s" % \
                [device_id, i, count, duration]
            t1 = Time.now
            count = 0
          end
          
        end #/ watch_high        
      end #/ thread      
    end
    
  end
  
  alias on_start start
  
  
end
