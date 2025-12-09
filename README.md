# V libui

V libui-ng wrapper and examples

V lang libui examples, forked from [libui_examples](https://github.com/funatsufumiya/libui_examples)

## Install (as a library)

```bash
$ git clone https://github.com/funatsufumiya/v-libui ~/.vmodules/libui
```

## Examples / how to build and run

> [!NOTE]
> Currently partial examples only translated into V

- [minimal](./examples/minimal/main.v)
- [timer](./examples/timer/main.v)
- [calendar](./examples/calendar/main.v)

### Windows

```bash
.\build.ps1

# then run each .exe in bin folder
```

### Mac

```bash
$ ./build.sh

# run executables, for example:
$ DYLD_LIBRARY_PATH=bin bin/graph
```

### Linux

```bash
$ ./build.sh

# run executables, for example:
$ LD_LIBRARY_PATH=bin bin/graph
```

-------

Original README

--------

# libui examples
Small [libui examples](https://github.com/andlabs/libui/tree/master/examples) that can be compile with [tiny c compile](https://bellard.org/tcc/)
Examples are automatically compiled and exposed at [actions](https://github.com/graysuit/libui_examples/actions/runs/1077977361) tab.

![screenshots/basic_controls.png](screenshots/basic_controls.png)

## Build and Run

### Windows

```bash
.\build.bat

# then run each .exe in bin folder
```

### Mac

```bash
$ ./build.sh

# run executables, for example:
$ DYLD_LIBRARY_PATH=bin bin/graph
```

### Linux

```bash
$ ./build.sh

# run executables, for example:
$ LD_LIBRARY_PATH=bin bin/graph
```

## Screenshots

![screenshots/basic_controls.png](screenshots/basic_controls.png)
![screenshots/calender.png](screenshots/calender.png)
![screenshots/data_choosers.png](screenshots/data_choosers.png)
![screenshots/graph.png](screenshots/graph.png)
![screenshots/label.png](screenshots/label.png)
![screenshots/numbers_and_lists.png](screenshots/numbers_and_lists.png)
![screenshots/timer.png](screenshots/timer.png)
