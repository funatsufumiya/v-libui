#!/bin/bash

cd $(dirname $0)

mkdir bin 1>/dev/null 2>/dev/null

# CC=clang
# $CC -lui -I. -L bin -o "bin/calender" "examples/calender/main.c" 
# $CC -lui -I. -L bin -o "bin/widgets" "examples/widgets/main.c" 
# $CC -lui -I. -L bin -o "bin/graph" "examples/graph/main.c" 
# $CC -lui -I. -L bin -o "bin/label" "examples/label/main.c" 
# $CC -lui -I. -L bin -o "bin/timer" "examples/timer/main.c" 
# $CC -lui -I. -L bin -o "bin/minimal" "examples/minimal/main.c" 

v examples/minimal/main.v -o bin/minimal
v -enable-globals examples/timer/main.v -o bin/timer
v -enable-globals examples/calendar/main.v -o bin/calendar
v -enable-globals examples/label/main.v -o bin/label
v -enable-globals examples/graph/main.v -o bin/graph
v -enable-globals examples/widgets/main.v -o bin/widgets