#!/bin/bash


function prepare_tracing_event()
{
    echo 0 > tracing_on
    echo 0 > options/function-trace
    echo "nop" > current_tracer

    echo "--------------current_tracer----------------------"
    cat current_tracer
    echo "--------------tracing_on----------------------"
    cat tracing_on
}

function start_tracing_event()
{
    # echo $1
    echo $1 > current_tracer
    echo 0 > tracing_on
    echo 1 > tracing_on
    echo "--------------current_tracer----------------------"
    cat current_tracer
    echo "--------------tracing_on----------------------"
    cat tracing_on
    echo "--------------sleep 5s----------------------"
    sleep 5
    echo 0 > tracing_on
    echo "--------------cat trace----------------------"
    cat trace
}

function main()
{
    # sudo chmod 777 /sys/kernel/debug
    # sudo chmod 777 /sys/kernel/debug/tracing
    # sudo chmod 777 /sys/kernel/debug/tracing/tracing_on
    # sudo chmod 777 /sys/kernel/debug/tracing/current_tracer
    # sudo chmod 777 /sys/kernel/debug/tracing/options/function-trace

    cd /sys/kernel/debug/tracing/
    echo "--------------ls -al----------------------"
    ls -al
    prepare_tracing_event
    start_tracing_event $1

}

# "hwlat blk mmiotrace function_graph wakeup_dl wakeup_rt wakeup function nop"
main "function"