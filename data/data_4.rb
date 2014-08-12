#!/usr/bin/env ruby
require 'ap'
s=`bash data_3.sh`
h={}
s.lines
s.lines.map(&:chomp).map do|l|
  date=l.split[0]
  key=l.split[1]
  value=l.split[2]
  if h[date].nil?
    h[date]={}
  end
  h[date][key]=value
end

puts "DATE,MINIMUM,MAXIMUM,AVERAGE"
h.each do |date, row|
  #ap row
  hash={}
  row.each do |key, value|
    hash[key]=value
  end
  puts "#{date},#{hash["MINIMUM"]},#{hash["MAXIMUM"]},#{hash["AVERAGE"]}"
end
