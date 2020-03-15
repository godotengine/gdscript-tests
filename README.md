# GDScript Tests

This repository contains script to test the GDScript implementation. Those are meant to make
sure that GDScript works as intended in all cases, especially when a change in the module
code is needed.

**NOTE**: Those are not meant to be used as testing engine features, only GDScript itself.
Eventually it might be extended, but for now they're only used to make sure that the GDScript
implementation is sound.

## Running tests

**NOTE**: Test suite is still not integrated in Godot. You can run it using a Godot build from this
branch: https://github.com/vnen/godot/tree/gdscript-test-suite

Clone this repository or download a ZIP and extract it in a folder somewhere.

Run: `godot --quiet --test-gdscript path/to/this/clone`

It will report failed tests in the terminal output.

## Making tests

Create a `.gd` file with a function called `test()` that don't receive any argument. This
function will be called by the test suite.

Then generate the `.out` file by running:

Run: `godot --quiet --generate-gdscript-tests path/to/this/clone`

## Code coverage report

The folder `misc/coverage-report` in this repository contains a generated code coverage
report created by the [`gcovr`](https://gcovr.com/en/stable/) tool. So you need to have it
installed and on your `PATH`.

First, you need to compile Godot on Linux with GCC or Clang with special flags. This won't work on other OSes
nor other compilers.

```
$ scons p=x11 CCFLAGS="-ftest-coverage -fprofile-arcs"
```

**NOTE**: After [PR #36572](https://github.com/godotengine/godot/pull/36572), you can use the added option instead:

```
$ scons p=x11 use_coverage=yes
```

After that, run the tests at least once. Then generate a report from the Godot source folder with
the script in the `misc/make-coverage-report.sh` in this repository:

```
$ path/to/this/clone/misc/make-coverage-report.sh
```

This will create a `coverage-report` folder with HTML files inside.

## Contributing with tests

Make a PR with new test scripts and their output file. If you can, also update the coverage report and include as an extra commit.

The main points for adding tests are:

- Reproducing a bug. This way we can make sure it's not reintroduced.
- Covering code in the GDScript implementation. Ideally all code paths are reached by some test.
    - Note that some paths are only reachable if there's a bug in the implementation, so it's very hard to
      make a script that reaches those. If you manage to do so, congratulations! Please provide the test and report
      the bug.
- In particular, testing if parser/compiler/runtime errors are being properly reported. If you find a case
  where an error should be shown, but it's not, it's a great addition for this repository.

Note that when you find a bug in GDScript, the generated `.out` file is not what you were expecting. In
this case, please manually patch the `.out` so it shows the expected output.
