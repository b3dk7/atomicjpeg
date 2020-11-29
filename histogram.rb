require 'histogram/array'
def format_q(s)
	return s.scan(/\d+/).join('-')
end

ARGV.each do |img|
	print File.basename(img)
	dct = `./dct_dump #{img} raw`
	dct = dct.split("\n").map(&:to_i)
	dct.sort!
	histogram = [*dct.group_by{ |v| v }.flat_map{ |k, v| [k, v.size] }]
	new_histogram = []
	$i = 0
	$num = histogram.size
	while $i < $num  do
		new_histogram << histogram[$i+1]
		$i +=2
	end
	$i = 1
	$num = new_histogram.size
	while $i < $num  do
		print ','+(new_histogram[$i].to_f/new_histogram[0]).to_s 
		$i +=1
	end
	print "\n"
end
