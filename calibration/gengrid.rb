#!/usr/bin/ruby

$pattern = '<rect style="fill:#000000;fill-opacity:1;stroke:none" id="rect2987-5" width="WWWmm" height="HHHmm" x="XXXmm" y="YYYmm" />'
$text = '<text xml:space="preserve" style="font-size:12px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;line-height:125%;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;font-family:Sans;-inkscape-font-specification:Times"
       x="XXXmm"
       y="YYYmm"
       id="text12982"
       sodipodi:linespacing="125%">SSS</text>'

def addtext(f, bx, by, s)
	f.puts $text.sub(/XXX/, (bx).to_s).sub(/YYY/, (by-1).to_s).sub(/SSS/, s)
end

def genchecker(f, bx, by, wh, maxwh)
	n = (maxwh / wh).floor.to_i
	(0..(n-1)).each{|x|
		(0..(n-1)).each{|y|
			next if (((x+y) % 2) == 1)
			f.puts $pattern.sub(/WWW/, wh.to_s).sub(/HHH/, wh.to_s).sub(/XXX/, (bx+wh*x).to_s).sub(/YYY/, (by+wh*y).to_s)
		}
	}
	addtext(f, bx, by, "Checker #{wh}mm spacing")
end

def gengrid(f, bx, by, wh, lw, maxwh)
	n = (maxwh / wh).floor.to_i
	(0..(n-1)).each{|x|
		f.puts $pattern.sub(/WWW/, lw.to_s).sub(/HHH/, (n*wh).to_s).sub(/XXX/, (bx+wh*x).to_s).sub(/YYY/, (by).to_s)
	}

	(0..(n-1)).each{|y|
		f.puts $pattern.sub(/WWW/, (n*wh).to_s).sub(/HHH/, lw.to_s).sub(/XXX/, (bx).to_s).sub(/YYY/, (by+wh*y).to_s)
	}
	addtext(f, bx, by, "Grid #{wh}mm spacing, #{lw}mm line width")
end

f = File.open("calib.svg", "w")


File.open("calib.svg.template").each{|line|
	if (line.chomp == "###DATA###") then
		genchecker(f, 20, 20, 1, 100)
		genchecker(f, 20, 140, 0.5, 50)
		genchecker(f,20, 200, 0.2, 50)
		gengrid(f, 130, 20, 1, 0.1, 50)
		gengrid(f, 130, 80, 1, 0.2, 50)
		gengrid(f, 130, 140, 1, 0.3, 50)
		gengrid(f, 130, 200, 2, 0.3, 50)
	else
		f.puts line
	end
}


