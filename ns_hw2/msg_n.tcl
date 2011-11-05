# This script is created by NSG2 beta1
# <http://wushoupong.googlepages.com/nsg>


#===================================
#     Simulation parameters setup
#===================================

#Mac/802_11 set dataRate_ 2Mb              ;#Rate for Data Frames
set val(chan)   Channel/WirelessChannel    ;# channel type
set val(prop)   Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)  Phy/WirelessPhy            ;# network interface type
set val(mac)    Mac/802_11                 ;# MAC type
set val(ifq)    Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)     LL                         ;# link layer type
set val(ant)    Antenna/OmniAntenna        ;# antenna model
set val(ifqlen) 50                         ;# max packet in ifq
set val(nn)     49                         ;# number of mobilenodes
set val(rp)     AODV                       ;# routing protocol
set val(x)      490                     ;# X dimension of topography
set val(y)      490                      ;# Y dimension of topography
set val(stop)   25.0                         ;# time of simulation end


# ================================================================================================= 
#     Initialize the PHY Layer Model
# ================================================================================================= 
 
    # Initialize the SharedMedia interface with parameters to make
    # it work like the 914MHz Lucent WaveLAN DSSS radio interface
 
    Phy/WirelessPhy set CPThresh_  10.0                         ;# capture threshold (db)
    Phy/WirelessPhy set CSThresh_  1.559e-11                    ;# carrier sense threshold (W)
    Phy/WirelessPhy set RXThresh_  3.652e-10                    ;# receive power threshold (W)
    Phy/WirelessPhy set bandwidth_ 2e6                          ;# 802.11b = 2 Mbps (default value) , 802.11a = 54 Mbps
    Phy/WirelessPhy set Pt_        0.28183815                   ;# transmitted signal power (W)
    Phy/WirelessPhy set freq_      914e+6                       ;# frequency
    Phy/WirelessPhy set L_         1.0                          ;# system loss factor
 

#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator]

#Setup topography object
set topo       [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)
#create-god [ expr $val(nn) ] 
#Mac/802_11 set RTSThreshold_ 3000 ;#RTS/CTS disable

#Open the NS trace file
set tracefile [open out.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile $val(x) $val(y)
set chan [new $val(chan)];#Create wireless channel

#===================================
#     Mobile node parameter setup
#===================================
$ns node-config -adhocRouting  $val(rp) \
                -llType        $val(ll) \
                -macType       $val(mac) \
                -ifqType       $val(ifq) \
                -ifqLen        $val(ifqlen) \
                -antType       $val(ant) \
                -propType      $val(prop) \
                -phyType       $val(netif) \
                -channel       $chan \
                -topoInstance  $topo \
                -agentTrace    ON \
                -routerTrace   ON \
                -macTrace      OFF \
                -movementTrace OFF

#===================================
#        Nodes Definition        
#===================================
#Create nodes
for {set i 0} {$i < 49} {incr i} {
    set node($i) [$ns node]
    $node($i) random-motion 0            ;# disable random motion
}

# Provide initial (X,Y, for now Z=0) co-ordinates for mobilenodes

for {set i 0} {$i < 7 } {incr i} {
    for {set j 0} {$j < 7 } {incr j} {
        $node([expr (7*$i+$j)]) set X_ [expr 70*$j]	
        $node([expr (7*$i+$j)]) set Y_ [expr 70*$i]
        $node([expr (7*$i+$j)]) set Z_ 0
     }
}
#===================================
#        Agents Definition        
#===================================

#===================================
#        Applications Definition        
#===================================

#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    #exec nam out.nam &
    exit 0
}

proc crate_random_cbr_connection { n_pair seed_val } {
global ns
set cbr_size 500
set cbr_interval 0.05
set start_time 5
set stop_time 25
#random set
set rng [new RNG]
$rng seed $seed_val
set u [new RandomVariable/Uniform]
$u set min_ 0
$u set max_ 48
$u use-rng $rng

    for {set i 0} {$i < $n_pair} {incr i} {
        set sender($i) [expr round([$u value])]
        set recevier($i) [expr round([$u value])]
        if {$sender($i) == $recevier($i)} {
            puts "ooops"
            set sender($i) [expr round([$u value])]
            set recevier($i) [expr round([$u value])]
        }
        puts "sender node: $sender($i) recevier node: $recevier($i)\n"
    }

    for {set j 0} {$j < $n_pair} {incr j} {
        set udp($j) [new Agent/UDP]
        $ns attach-agent $::node($sender($j)) $udp($j)
        set cbr_($j) [new Application/Traffic/CBR]
        $cbr_($j) set packetSize_ $cbr_size
        $cbr_($j) set interval_ $cbr_interval
        $cbr_($j) attach-agent $udp($j) 
        set null($j) [new Agent/Null]
        $ns attach-agent $::node($recevier($j)) $null($j)
        $ns connect $udp($j) $null($j)
        
        $ns at $start_time "$cbr_($j) start"
        $ns at $stop_time "$cbr_($j) stop"
    }
    
}
if {$argc != 2} {
    puts "you are wrong!!"
} else {
    crate_random_cbr_connection  [lindex $argv 0] [lindex $argv 1]
}

$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run

