# If the Kinetic Task version is under 4, load the openssl and json libraries
# because they are not included in the ruby version
if KineticTask::VERSION.split(".").first.to_i < 4
  # Load the JRuby Open SSL library unless it has already been loaded.  This
  # prevents multiple handlers using the same library from causing problems.
  if not defined?(Jopenssl)
    # Load the Bouncy Castle library unless it has already been loaded.  This
    # prevents multiple handlers using the same library from causing problems.
    # Calculate the location of this file
    handler_path = File.expand_path(File.dirname(__FILE__))
    # Calculate the location of our library and add it to the Ruby load path
    library_path = File.join(handler_path, 'vendor/bouncy-castle-java-1.5.0147/lib')
    $:.unshift library_path
    # Require the library
    require 'bouncy-castle-java'


    # Calculate the location of this file
    handler_path = File.expand_path(File.dirname(__FILE__))
    # Calculate the location of our library and add it to the Ruby load path
    library_path = File.join(handler_path, 'vendor/jruby-openssl-0.8.8/lib/shared')
    $:.unshift library_path
    # Require the library
    require 'openssl'
    # Require the version constant
    require 'jopenssl/version'
  end

  # Validate the the loaded openssl library is the library that is expected for
  # this handler to execute properly.
  if not defined?(Jopenssl::Version::VERSION)
    raise "The Jopenssl class does not define the expected VERSION constant."
  elsif Jopenssl::Version::VERSION != '0.8.8'
    raise "Incompatible library version #{Jopenssl::Version::VERSION} for Jopenssl.  Expecting version 0.8.8"
  end
end


# Load the ruby Rack library unless it has already been loaded.  This prevents
# multiple handlers using the same library from causing problems.
if not defined?(Rack)
  # Calculate the location of this file
  handler_path = File.expand_path(File.dirname(__FILE__))
  # Calculate the location of our library and add it to the Ruby load path
  library_path = File.join(handler_path, 'vendor/rack-2.0.6/lib')
  $:.unshift library_path
  # Require the library
  require 'rack'
end

# Validate the the loaded Rack library is the library that is expected for
# this handler to execute properly.
if not defined?(Rack.release)
  raise "The Rack class does not define the expected VERSION constant."
elsif Rack.release != '2.0.6'
  raise "Incompatible library version #{Rack.release} for Rack.  Expecting version 2.0.6."
end

# Load the ruby Builder library unless it has already been loaded.  This prevents
# multiple handlers using the same library from causing problems.
if not defined?(Builder)
  # Calculate the location of this file
  handler_path = File.expand_path(File.dirname(__FILE__))
  # Calculate the location of our library and add it to the Ruby load path
  library_path = File.join(handler_path, 'vendor/builder-3.2.3/lib')
  $:.unshift library_path
  # Require the library
  require 'builder'
  require 'builder/version' unless defined?(Builder::VERSION)
end

# Validate the the loaded Builder library is the library that is expected for
# this handler to execute properly.
if not defined?(Builder::VERSION)
  raise "The Builder class does not define the expected VERSION constant."
elsif Builder::VERSION != '3.2.3'
  raise "Incompatible library version #{Builder::VERSION} for Builder.  Expecting version 3.2.3."
end

# Load the ruby Gyoku library unless it has already been loaded.  This prevents
# multiple handlers using the same library from causing problems.
if not defined?(Gyoku)
  # Calculate the location of this file
  handler_path = File.expand_path(File.dirname(__FILE__))
  # Calculate the location of our library and add it to the Ruby load path
  library_path = File.join(handler_path, 'vendor/gyoku-1.3.1/lib')
  $:.unshift library_path
  # Require the library
  require 'gyoku'
end

# Validate the the loaded Gyoku library is the library that is expected for
# this handler to execute properly.
if not defined?(Gyoku::VERSION)
  raise "The Gyoku class does not define the expected VERSION constant."
elsif Gyoku::VERSION != '1.3.1'
  raise "Incompatible library version #{Gyoku::VERSION} for Gyoku.  Expecting version 1.3.1."
end

# Load the ruby Nokogiri library unless it has already been loaded.  This prevents
# multiple handlers using the same library from causing problems.
if not defined?(Nokogiri)
  # Calculate the location of this file
  handler_path = File.expand_path(File.dirname(__FILE__))
  # Calculate the location of our library and add it to the Ruby load path
  library_path = File.join(handler_path, 'vendor/nokogiri-1.8.5-java/lib')
  $:.unshift library_path
  # Require the library
  require 'nokogiri'
  require 'nokogiri/version'
end

# Validate the the loaded Nokogiri library is the library that is expected for
# this handler to execute properly.
if not defined?(Nokogiri::VERSION)
  raise "The Nokogiri class does not define the expected VERSION constant."
elsif Nokogiri::VERSION != '1.8.5'
  raise "Incompatible library version #{Nokogiri::VERSION} for Nokogiri.  Expecting version 1.8.5."
end

# Load the ruby Akami library unless it has already been loaded.  This prevents
# multiple handlers using the same library from causing problems.
if not defined?(Akami)
  # Calculate the location of this file
  handler_path = File.expand_path(File.dirname(__FILE__))
  # Calculate the location of our library and add it to the Ruby load path
  library_path = File.join(handler_path, 'vendor/akami-1.3.1/lib')
  $:.unshift library_path
  # Require the library
  require 'akami'
end

# Validate the the loaded Akami library is the library that is expected for
# this handler to execute properly.
if not defined?(Akami::VERSION)
  raise "The Akami class does not define the expected VERSION constant."
elsif Akami::VERSION != '1.3.1'
  raise "Incompatible library version #{Akami::VERSION} for Akami.  Expecting version 1.3.1."
end

# Load the ruby Httpi library unless it has already been loaded.
# This prevents multiple handlers using the same library from causing problems.
if not defined?(Socksify)
  # Calculate the location of this file
  handler_path = File.expand_path(File.dirname(__FILE__))
  # Calculate the location of our library and add it to the Ruby load path
  library_path = File.join(handler_path, 'vendor/socksify-1.7.1/lib')
  $:.unshift library_path
  # Require the library
  require 'socksify'
end

# Load the ruby Httpi library unless it has already been loaded.
# This prevents multiple handlers using the same library from causing problems.
if not defined?(HTTPI)
  # Calculate the location of this file
  handler_path = File.expand_path(File.dirname(__FILE__))
  # Calculate the location of our library and add it to the Ruby load path
  library_path = File.join(handler_path, 'vendor/httpi-2.4.4/lib')
  $:.unshift library_path
  # Require the library
  require 'httpi'
end

# Validate the the loaded Httpi library is the library that is expected for
# this handler to execute properly.
if not defined?(HTTPI::VERSION)
  raise "The Httpi class does not define the expected VERSION constant."
elsif HTTPI::VERSION != '2.4.4'
  raise "Incompatible library version #{HTTPI::VERSION} for Httpi.  Expecting version 2.4.4."
end

# Load the ruby Nori library unless it has already been loaded.  This prevents
# multiple handlers using the same library from causing problems.
if not defined?(Nori)
  # Calculate the location of this file
  handler_path = File.expand_path(File.dirname(__FILE__))
  # Calculate the location of our library and add it to the Ruby load path
  library_path = File.join(handler_path, 'vendor/nori-2.6.0/lib')
  $:.unshift library_path
  # Require the library
  require 'nori'
end

# Validate the the loaded Nori library is the library that is expected for
# this handler to execute properly.
if not defined?(Nori::VERSION)
  raise "The Nori class does not define the expected VERSION constant."
elsif Nori::VERSION != '2.6.0'
  raise "Incompatible library version #{Nori::VERSION} for Nori.  Expecting version 2.6.0."
end





# Load the ruby Wasabi library unless it has already been loaded.  This prevents
# multiple handlers using the same library from causing problems.
if not defined?(Wasabi)
  # Calculate the location of this file
  handler_path = File.expand_path(File.dirname(__FILE__))
  # Calculate the location of our library and add it to the Ruby load path
  library_path = File.join(handler_path, 'vendor/wasabi-3.5.0/lib')
  $:.unshift library_path
  # Require the library
  require 'wasabi'
end

# Validate the the loaded Wasabi library is the library that is expected for
# this handler to execute properly.
if not defined?(Wasabi::VERSION)
  raise "The Wasabi class does not define the expected VERSION constant."
elsif Wasabi::VERSION != '3.5.0'
  raise "Incompatible library version #{Wasabi::VERSION} for Wasabi.  Expecting version 3.5.0."
end

# Load the ruby Savon library unless it has already been loaded.  This prevents
# multiple handlers using the same library from causing problems.
if not defined?(Savon)
  # Calculate the location of this file
  handler_path = File.expand_path(File.dirname(__FILE__))
  # Calculate the location of our library and add it to the Ruby load path
  library_path = File.join(handler_path, 'vendor/savon-2.12.0/lib')
  $:.unshift library_path
  # Require the library
  require 'savon'
end

# Validate the the loaded Savon library is the library that is expected for
# this handler to execute properly.
if not defined?(Savon::VERSION)
  raise "The Savon class does not define the expected VERSION constant."
elsif Savon::VERSION != '2.12.0'
  raise "Incompatible library version #{Savon::VERSION} for Savon.  Expecting version 2.12.0."
end

# Load the ruby Netsuit library unless it has already been loaded.  This prevents
# multiple handlers using the same library from causing problems.
if not defined?(NetSuite)
  # Calculate the location of this file
  handler_path = File.expand_path(File.dirname(__FILE__))
  # Calculate the location of our library and add it to the Ruby load path
  library_path = File.join(handler_path, 'vendor/netsuite-0.8.10/lib')
  $:.unshift library_path
  # Require the library
  require 'netsuite'
end

# Validate the the loaded Savon library is the library that is expected for
# this handler to execute properly.
if not defined?(NetSuite::VERSION)
  raise "The NetSuite class does not define the expected VERSION constant."
elsif NetSuite::VERSION != '0.8.10'
  raise "Incompatible library version #{NetSuite::VERSION} for NetSuite.  Expecting version 0.8.10."
end