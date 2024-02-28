#!/bin/bash
SA=$1

for IRQ in $(ls /proc/irq/ | grep [[:digit:]]); do
    echo Before $IRQ
    cat /proc/irq/$IRQ/smp_affinity
    echo $SA > /proc/irq/$IRQ/smp_affinity
    echo After $IRQ
    cat /proc/irq/$IRQ/smp_affinity
done;
