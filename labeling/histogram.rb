require 'exifr/jpeg'
require 'histogram/array'  # enables Array#histogram

#puts 'File Name,Make,Model,Software,qt1,qt2,histogram'


def format_q(s)
    return s.scan(/\d+/).join('-')
end

ARGV.each do |img|
    #puts i.to_s + ": "
    #i+=1
    #data = EXIFR::JPEG.new(img)
    
    print File.basename(img)
    #q_tables = `djpeg -verbose -verbose #{img} > /dev/null 2> q_tables.txt`
    
    dct = `./customdump #{img} raw`
    dct = dct.split("\n").map(&:to_i)
    
    #dct.reject! {|x| x < 2 or x > 30}
    #dct.reject! {|x| x > 30}
    
    dct.sort!
    
    
    #puts dct
    
    #puts dct.size
    
    
    #puts dct
    #puts dct[0..200]
    
    #print dct
    #histogram = dct.
    
    #puts dct.size
    #dct = [1,2]
    #(bins, freqs) = dct[0..2].histogram
    #(bins, freqs) = dct.histogram
    
    #print bins
    
    histogram = [*dct.group_by{ |v| v }.flat_map{ |k, v| [k, v.size] }]
    #print histogram[0]
    #print histogram[1]
    
   new_histogram = []
    
    $i = 0
    $num = histogram.size

    while $i < $num  do
        #puts histogram[$i].to_s+','+histogram[$i+1].to_s
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
    
    #puts new_histogram.size
    
    
    #q_tables.each_line do |line|
        #puts "hi"
        #if line.include? "Define Quantization Table"
         #   puts line
        #end
    #end
    #puts histogram[0]
    
    #histogram.each 
    
    
    #count = 0
    #histogram.each do |coef, count|
        #puts coef
    #end
    #pre_match = doc.match(/"o":{"displayUrl":".*,"key":"o"/).to_s
=begin
    q1 = ""
    q2 = ""
    
    #puts q_tables
    record = false
    lines_remaining = 18
    File.open('q_tables.txt').each do |line|
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
    
    
    
    #puts File.basename(img)+','+data.make.to_s+','+data.model.to_s+','+data.software.to_s+','+q1+','+q2+','+histogram[0]
    
    
=end    
    
    
end
