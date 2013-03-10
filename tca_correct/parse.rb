#!/usr/bin/ruby

alldata = []

# Generate params.db file (for display in R)

f = File.open("params.db", "w")

f.puts "r0\tr1\tr2\tr3\tb0\tb1\tb2\tb3"

File.open("params.log").each{|line|
	if (match = line.match(/-r ([0-9\-.:]*) -b ([0-9\-.:]*)/)) then
		data = (match[1].split(/:/) + match[2].split(/:/)).map{|x| x.to_f}
		f.puts data.join("\t")
		alldata << data
	end
}

f.close

# Obtain median for each parameter

median = (0..(alldata[0].length-1)).map{|x|
	param = alldata.map{|data| data[x]}.sort
	if (param.length % 2 == 0) then
		0.5*(param[param.length/2]+param[param.length/2-1])
	else
		param[param.length/2]
	end
}.map{|f| "%.7f" % f}

puts "-r " + median[0..3].join(":") + " -b " + median[4..7].join(":")

