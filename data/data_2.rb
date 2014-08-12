#!/usr/bin/env ruby

Dir.glob('./*.out').each do |file|
  f = File.open(file,'r')
  print f.readlines[1]
end
