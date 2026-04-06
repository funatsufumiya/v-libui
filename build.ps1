Set-Location $PSScriptRoot

# mkdir bin

Try { mkdir bin -ErrorAction SilentlyContinue > $null } Catch {}

v "examples/minimal/main.v" -o "bin/minimal.exe"
v -enable-globals "examples/timer/main.v" -o "bin/timer.exe"
v -enable-globals "examples/calendar/main.v" -o "bin/calendar.exe"
v -enable-globals "examples/label/main.v" -o "bin/label.exe"
v -enable-globals "examples/graph/main.v" -o "bin/graph.exe"
v -enable-globals "examples/widgets/main.v" -o "bin/widgets.exe"
