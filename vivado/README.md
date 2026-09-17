# Vivado project

The author's initial Vivado 2026.1 project is preserved separately. Its
source paths referred to files inside `project_1.srcs`, including a testbench
under Design Sources and a duplicate `matrix2x2_tb.v`. Copying that `.xpr`
alone would not make a portable GitHub project.

Run `create_project.tcl` from the repository root to generate a fresh project:

```powershell
vivado -mode batch -source vivado/create_project.tcl
```

On Windows, use the installed `vivado.bat` path if `vivado` is not on PATH. Open
`vivado/build/tiny_mac.xpr` in Vivado after generation. The Tcl script uses
the script's own location, so it can be run from another working directory.
The `rtl/` files are Design Sources; `tb/` files are Simulation Sources.
The synthesis top is `matrix2x2`, and the default simulation top is
`matrix2x2_tb`. To simulate another testbench in the GUI, set that module as
the Simulation Sources top first.

To run all four self-checking testbenches from the generated project:

```powershell
vivado -mode batch -source vivado/run_tests.tcl
```

This script checks each simulator log for its `PASS` result and stops with an
error if a test fails. It restores `matrix2x2_tb` as the default simulation top.

To regenerate synthesis utilization, run:

```powershell
vivado -mode batch -source vivado/run_synthesis.tcl
```

The report is written to `vivado/build/tiny_mac_utilization_synth.rpt`.
Vivado 2026.1 may print a warning about an empty board-part property when
opening the generated project. The device part is set correctly, and this
project has no board pin constraints. Synthesis of the RTL completed without
synthesis warnings in the checked run.

The generated `build/` directory, runs, caches, simulation results, and logs
are ignored by Git. Commit the Tcl scripts with `rtl/` and `tb/`; there
are no IP or constraint files required for this small RTL exercise. The
design has no pin assignments or board implementation claim.
