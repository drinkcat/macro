#!/usr/bin/ruby

$pattern = '<rect style="fill:#000000;fill-opacity:1;stroke:none" id="rect2987-5" width="WWWmm" height="HHHmm" x="XXXmm" y="YYYmm" />'

def gengrid(f, bx, by, wh, maxwh)
	n = (maxwh / wh).floor.to_i
	(0..(n-1)).each{|x|
		(0..(n-1)).each{|y|
			next if (((x+y) % 2) == 1)
			f.puts $pattern.sub(/WWW/, wh.to_s).sub(/HHH/, wh.to_s).sub(/XXX/, (bx+wh*x).to_s).sub(/YYY/, (by+wh*y).to_s)
		}
	}
end

def gensquare(f, bx, by, wh, lw, maxwh)
	n = (maxwh / wh).floor.to_i
	(0..(n-1)).each{|x|
		f.puts $pattern.sub(/WWW/, lw.to_s).sub(/HHH/, (n*wh).to_s).sub(/XXX/, (bx+wh*x).to_s).sub(/YYY/, (by).to_s)
	}

	(0..(n-1)).each{|y|
		f.puts $pattern.sub(/WWW/, (n*wh).to_s).sub(/HHH/, lw.to_s).sub(/XXX/, (bx).to_s).sub(/YYY/, (by+wh*y).to_s)
	}
end

f = File.open("calib.svg", "w")


File.open("calib.svg.template").each{|line|
	if (line.chomp == "###DATA###") then
		gengrid(f, 20, 20, 1, 100)
		gengrid(f, 20, 140, 0.5, 50)
		gengrid(f,20, 200, 0.2, 50)
		gensquare(f, 130, 20, 1, 0.1, 50)
		gensquare(f, 130, 80, 1, 0.2, 50)
		gensquare(f, 130, 140, 1, 0.3, 50)
		gensquare(f, 130, 200, 2, 0.3, 50)
	else
		f.puts line
	end
}


