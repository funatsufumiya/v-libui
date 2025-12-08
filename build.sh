#!/bin/bash

cd $(dirname $0)

mkdir bin

CC=clang
$CC -lui -I. -L bin -o "bin/calender" "examples/calender/main.c" 
$CC -lui -I. -L bin -o "bin/widgets" "examples/widgets/main.c" 
$CC -lui -I. -L bin -o "bin/graph" "examples/graph/main.c" 
$CC -lui -I. -L bin -o "bin/label" "examples/label/main.c" 
$CC -lui -I. -L bin -o "bin/timer" "examples/timer/main.c" 
$CC -lui -I. -L bin -o "bin/minimal" "examples/minimal/main.c" 
