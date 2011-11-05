#!/bin/bash
#author: Chen Si Cool :)
cp delay* ./old_d/
cp throug* ./old_t/
rm delay*
rm throughtput*
times = 10
for ((i=1;i<=20;i++));do
    for ((j=0;j<10;j++));do
        echo $i;
        echo $RANDOM;
        ns msg_n.tcl $i $RANDOM;
        perl mea.pl out.tr >> throughtput_$i;
        perl del.pl out.tr >> delay_$i;
    done;
done;

