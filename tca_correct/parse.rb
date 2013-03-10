#!/usr/bin/ruby

puts "r0\tr1\tr2\tr3\tb0\tb1\tb2\tb3"

File.open("params.log").each{|line|
	if (match = line.match(/-r ([0-9\-.:]*) -b ([0-9\-.:]*)/)) then
		print match[1].split(/:/).join("\t")
		print "\t"
		puts match[2].split(/:/).join("\t")
	end
}

