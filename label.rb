require 'exifr/jpeg'

puts 'File Name,Make,Model,Software,qt1,qt2,huffman-tables'
def format_q(s)
	return s.scan(/\d+/).join('-')
end
ARGV.each do |img|
	data = EXIFR::JPEG.new(img)
	q_tables = `./jpeg-8a/djpeg -verbose -verbose #{img} > /dev/null 2> q_tables.txt`
	q1 = ""
	q2 = ""
	record = false
	lines_remaining = 18
	huffman_tables = 0
	File.open('q_tables.txt').each do |line|
		if line.include? "Define Huffman Table"
			huffman_tables+=1
		end
		if line.include? "Define Quantization Table"
			record = true
		end
		if record and lines_remaining>0
			#puts lines_remaining
			if lines_remaining != 18 and lines_remaining != 9
				#puts line
				if lines_remaining<9
					q1 << line
				else
					q2 << line
				end
			end
			lines_remaining-=1
		end
		
	end
	q1 = format_q(q1)
	q2 = format_q(q2)
	puts File.basename(img)+','+data.make.to_s+','+data.model.to_s+','+data.software.to_s+','+q1+','+q2+','+huffman_tables.to_s
end
