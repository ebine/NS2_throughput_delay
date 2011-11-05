# This script is created by NSG2 beta1
# <http://wushoupong.googlepages.com/nsg>

#===================================
#     Simulation parameters setup
#===================================
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
set val(x)      1161                      ;# X dimension of topography
set val(y)      1083                      ;# Y dimension of topography
set val(stop)   25.0                         ;# time of simulation end

#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator]

#Setup topography object
set topo       [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)

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
                -macTrace      ON \
                -movementTrace ON

#===================================
#        Nodes Definition        
#===================================
#Create 49 nodes
set n0 [$ns node]
$n0 set X_ 641
$n0 set Y_ 983
$n0 set Z_ 0.0
$ns initial_node_pos $n0 20
set n1 [$ns node]
$n1 set X_ 711
$n1 set Y_ 983
$n1 set Z_ 0.0
$ns initial_node_pos $n1 20
set n2 [$ns node]
$n2 set X_ 781
$n2 set Y_ 983
$n2 set Z_ 0.0
$ns initial_node_pos $n2 20
set n3 [$ns node]
$n3 set X_ 851
$n3 set Y_ 983
$n3 set Z_ 0.0
$ns initial_node_pos $n3 20
set n4 [$ns node]
$n4 set X_ 921
$n4 set Y_ 983
$n4 set Z_ 0.0
$ns initial_node_pos $n4 20
set n5 [$ns node]
$n5 set X_ 991
$n5 set Y_ 983
$n5 set Z_ 0.0
$ns initial_node_pos $n5 20
set n6 [$ns node]
$n6 set X_ 1061
$n6 set Y_ 983
$n6 set Z_ 0.0
$ns initial_node_pos $n6 20
set n7 [$ns node]
$n7 set X_ 641
$n7 set Y_ 913
$n7 set Z_ 0.0
$ns initial_node_pos $n7 20
set n8 [$ns node]
$n8 set X_ 711
$n8 set Y_ 913
$n8 set Z_ 0.0
$ns initial_node_pos $n8 20
set n9 [$ns node]
$n9 set X_ 781
$n9 set Y_ 913
$n9 set Z_ 0.0
$ns initial_node_pos $n9 20
set n10 [$ns node]
$n10 set X_ 851
$n10 set Y_ 913
$n10 set Z_ 0.0
$ns initial_node_pos $n10 20
set n11 [$ns node]
$n11 set X_ 921
$n11 set Y_ 913
$n11 set Z_ 0.0
$ns initial_node_pos $n11 20
set n12 [$ns node]
$n12 set X_ 991
$n12 set Y_ 913
$n12 set Z_ 0.0
$ns initial_node_pos $n12 20
set n13 [$ns node]
$n13 set X_ 1061
$n13 set Y_ 913
$n13 set Z_ 0.0
$ns initial_node_pos $n13 20
set n14 [$ns node]
$n14 set X_ 641
$n14 set Y_ 843
$n14 set Z_ 0.0
$ns initial_node_pos $n14 20
set n15 [$ns node]
$n15 set X_ 711
$n15 set Y_ 843
$n15 set Z_ 0.0
$ns initial_node_pos $n15 20
set n16 [$ns node]
$n16 set X_ 781
$n16 set Y_ 843
$n16 set Z_ 0.0
$ns initial_node_pos $n16 20
set n17 [$ns node]
$n17 set X_ 851
$n17 set Y_ 843
$n17 set Z_ 0.0
$ns initial_node_pos $n17 20
set n18 [$ns node]
$n18 set X_ 921
$n18 set Y_ 843
$n18 set Z_ 0.0
$ns initial_node_pos $n18 20
set n19 [$ns node]
$n19 set X_ 991
$n19 set Y_ 843
$n19 set Z_ 0.0
$ns initial_node_pos $n19 20
set n20 [$ns node]
$n20 set X_ 1061
$n20 set Y_ 843
$n20 set Z_ 0.0
$ns initial_node_pos $n20 20
set n21 [$ns node]
$n21 set X_ 641
$n21 set Y_ 773
$n21 set Z_ 0.0
$ns initial_node_pos $n21 20
set n22 [$ns node]
$n22 set X_ 711
$n22 set Y_ 773
$n22 set Z_ 0.0
$ns initial_node_pos $n22 20
set n23 [$ns node]
$n23 set X_ 781
$n23 set Y_ 773
$n23 set Z_ 0.0
$ns initial_node_pos $n23 20
set n24 [$ns node]
$n24 set X_ 851
$n24 set Y_ 773
$n24 set Z_ 0.0
$ns initial_node_pos $n24 20
set n25 [$ns node]
$n25 set X_ 921
$n25 set Y_ 773
$n25 set Z_ 0.0
$ns initial_node_pos $n25 20
set n26 [$ns node]
$n26 set X_ 991
$n26 set Y_ 773
$n26 set Z_ 0.0
$ns initial_node_pos $n26 20
set n27 [$ns node]
$n27 set X_ 1061
$n27 set Y_ 773
$n27 set Z_ 0.0
$ns initial_node_pos $n27 20
set n28 [$ns node]
$n28 set X_ 641
$n28 set Y_ 703
$n28 set Z_ 0.0
$ns initial_node_pos $n28 20
set n29 [$ns node]
$n29 set X_ 711
$n29 set Y_ 703
$n29 set Z_ 0.0
$ns initial_node_pos $n29 20
set n30 [$ns node]
$n30 set X_ 781
$n30 set Y_ 703
$n30 set Z_ 0.0
$ns initial_node_pos $n30 20
set n31 [$ns node]
$n31 set X_ 851
$n31 set Y_ 703
$n31 set Z_ 0.0
$ns initial_node_pos $n31 20
set n32 [$ns node]
$n32 set X_ 921
$n32 set Y_ 703
$n32 set Z_ 0.0
$ns initial_node_pos $n32 20
set n33 [$ns node]
$n33 set X_ 991
$n33 set Y_ 703
$n33 set Z_ 0.0
$ns initial_node_pos $n33 20
set n34 [$ns node]
$n34 set X_ 1061
$n34 set Y_ 703
$n34 set Z_ 0.0
$ns initial_node_pos $n34 20
set n35 [$ns node]
$n35 set X_ 641
$n35 set Y_ 633
$n35 set Z_ 0.0
$ns initial_node_pos $n35 20
set n36 [$ns node]
$n36 set X_ 711
$n36 set Y_ 633
$n36 set Z_ 0.0
$ns initial_node_pos $n36 20
set n37 [$ns node]
$n37 set X_ 781
$n37 set Y_ 633
$n37 set Z_ 0.0
$ns initial_node_pos $n37 20
set n38 [$ns node]
$n38 set X_ 851
$n38 set Y_ 633
$n38 set Z_ 0.0
$ns initial_node_pos $n38 20
set n39 [$ns node]
$n39 set X_ 921
$n39 set Y_ 633
$n39 set Z_ 0.0
$ns initial_node_pos $n39 20
set n40 [$ns node]
$n40 set X_ 991
$n40 set Y_ 633
$n40 set Z_ 0.0
$ns initial_node_pos $n40 20
set n41 [$ns node]
$n41 set X_ 1061
$n41 set Y_ 633
$n41 set Z_ 0.0
$ns initial_node_pos $n41 20
set n42 [$ns node]
$n42 set X_ 641
$n42 set Y_ 563
$n42 set Z_ 0.0
$ns initial_node_pos $n42 20
set n43 [$ns node]
$n43 set X_ 711
$n43 set Y_ 563
$n43 set Z_ 0.0
$ns initial_node_pos $n43 20
set n44 [$ns node]
$n44 set X_ 781
$n44 set Y_ 563
$n44 set Z_ 0.0
$ns initial_node_pos $n44 20
set n45 [$ns node]
$n45 set X_ 851
$n45 set Y_ 563
$n45 set Z_ 0.0
$ns initial_node_pos $n45 20
set n46 [$ns node]
$n46 set X_ 921
$n46 set Y_ 563
$n46 set Z_ 0.0
$ns initial_node_pos $n46 20
set n47 [$ns node]
$n47 set X_ 991
$n47 set Y_ 563
$n47 set Z_ 0.0
$ns initial_node_pos $n47 20
set n48 [$ns node]
$n48 set X_ 1061
$n48 set Y_ 563
$n48 set Z_ 0.0
$ns initial_node_pos $n48 20

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
    exec nam out.nam &
    exit 0
}
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "\$n$i reset"
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run
