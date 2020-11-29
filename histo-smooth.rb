require 'exifr/jpeg'
require 'histogram/array'


def format_q(s)
    return s.scan(/\d+/).join('-')
end

ARGV.each do |img|
    
    print File.basename(img)+','
    
    dct = `./customdump #{img} raw`
    dct = dct.split("\n").map(&:to_i)
    

    
    dct.sort!
    
    

    
    histogram = [*dct.group_by{ |v| v }.flat_map{ |k, v| [k, v.size] }]

    
   new_histogram = []
    
    $i = 0
    $num = histogram.size

    while $i < $num  do
        #puts histogram[$i].to_s+','+histogram[$i+1].to_s
        new_histogram << histogram[$i+1]
        
        $i +=2
    end
    
    
    
    list = []
    
    $i = 1
    $num = new_histogram.size
    while $i < $num  do
        list << new_histogram[$i].to_f/new_histogram[$i-1]
        
        $i +=1
    end
    
    
    #[1, 2, 3].map { |n| n * n } #=> [1, 4, 9]
    
    list.map! { |n| Math.sqrt(n) }
    
    
    sum=0
    list.each do |i|
        sum += i
    end
    
    average = sum / list.size
    
    
    #puts average
    
    error=0
    list.each do |i|
        error += (i-average).abs
    end
    
    average_error = error/list.size
    puts average_error
    
    
    
    #puts Math.sqrt(26)
    
   
    
    
end
