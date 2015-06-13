Gem::Specification.new do |s|
  s.name = 'humble_rpi-plugin-pir'
  s.version = '0.1.1'
  s.summary = 'A humble_rpi plugin which detects motion for 1 or more PIR sensor.'
  s.description = 'This plugin can be tested in isolation with the Raspberry Pi.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/humble_rpi-plugin-pir.rb']
  s.add_runtime_dependency('pi_piper', '~> 1.3', '>=1.3.2')  
  s.add_runtime_dependency('chronic_duration', '~> 0.10', '>=0.10.6')
  s.signing_key = '../privatekeys/humble_rpi-plugin-pir.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/humble_rpi-plugin-pir'
end
