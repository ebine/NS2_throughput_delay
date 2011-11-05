#!/usr/bin/perl

#trace file name
$infile = $ARGV[0];

#time interval(s)
$granularity = 10;

#save the first time
$init=0;
$start = 0;

#hashtable to store send packet number
%pre_send_packet;

#hashtable to store delay info
%delay_hash_table;

#defin type to consider
$type_to_consider = "tcp";
$layter_to_consider ="AGT";
$send = "s";
$rec = "r";

open(DATA, "<$infile")
|| die "cannot open $infile $!";

while(<DATA>){
    @x = split(' ');
    $time = $x[1];
    $packet_layer = $x[3];
    $send_or_rec = $x[0];
    $packet_num = $x[5];
    $packet_type = $x[6];
    if($init == 0){
        $start = $time;
        $init=1;
    }
    if(($packet_type =~/^$type_to_consider$/i) 
        && ($send_or_rec =~/^$send$/i)
        && ($packet_layer =~/^$layter_to_consider$/i)){

        #only store the first(early) send packet's time
        if($pre_send_packet{$packet_num} > $time ||
            $pre_send_packet{$packet_num}== 0){
            $pre_send_packet{$packet_num}= $time;
        }
    }


    if(($packet_type =~/^$type_to_consider$/i) 
        && ($send_or_rec =~/^$rec$/i)
        && ($packet_layer =~/^$layter_to_consider$/i)){
        while(($key,$value) = each(%pre_send_packet)){
            if($key == $packet_num){
                $delay = $time - $value;

                #the delay time is considered in the received time interval
                $delay_hash_table{$time} = $delay;
                delete($pre_send_packet{$key});
            }
        }
    }
}

#save the endtime
$endtime = $time;
$end = int($endtime / $granularity);

my @delay_array = (0) x ($end+1);
my @delay_array_count = (0) x ($end+1);
while(($key,$value) = each(%delay_hash_table)){
    $key = int($key/$granularity);

    #count the sum of delays in certain time interval
    $delay_array[$key] += $value;

    #count the number of delays in certain time interval
    if($value > 0){
        $delay_array_count[$key] +=1;
    }
}
#print @delay_array_count;
$i=0;
while($i<=$end){
    $j = $granularity * $i;
    $k = $j + $granularity;
    $total += $delay_array[$i];
    $total_count += $delay_array_count[$i];
    if($total_count > 0){
        $avg = $total / $total_count;
    }
    else{
        $avg = 0;
    }
    
    print "Delay $j - $k : $avg \n";
    $i++;
}
$final_avg = $total / $total_count;
print "avg:$final_avg\n"; 

#finished,...
close DATA;
exit(0)
