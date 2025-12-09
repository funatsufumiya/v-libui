Set-Location $PSScriptRoot

# mkdir bin

Try { mkdir bin -ErrorAction SilentlyContinue > $null } Catch {}

# @REM set "tcc=%CD%/tcc/tcc.exe"

# @REM %tcc% -llibui -L%CD% -o "%CD%/bin/calender.exe" "%CD%/examples/calender/main.c" 
# @REM %tcc% -llibui -L%CD% -o "%CD%/bin/widgets.exe" "%CD%/examples/widgets/main.c" 
# @REM %tcc% -llibui -L%CD% -o "%CD%/bin/graph.exe" "%CD%/examples/graph/main.c" 
# @REM %tcc% -llibui -L%CD% -o "%CD%/bin/label.exe" "%CD%/examples/label/main.c" 
# @REM %tcc% -llibui -L%CD% -o "%CD%/bin/timer.exe" "%CD%/examples/timer/main.c" 
# @REM %tcc% -llibui -L%CD% -o "%CD%/bin/minimal.exe" "%CD%/examples/minimal/main.c" 

v "examples/minimal/main.v" -o "bin/minimal.exe"
v -enable-globals "examples/timer/main.v" -o "bin/timer.exe"
v -enable-globals "examples/calendar/main.v" -o "bin/calendar.exe"
