# Generate the project first with create_project.tcl.
set script_dir [file dirname [file normalize [info script]]]
set build_dir [file join $script_dir build]

open_project [file join $build_dir tiny_mac.xpr]
reset_run synth_1
launch_runs synth_1
wait_on_run synth_1
open_run synth_1
report_utilization -file [file join $build_dir tiny_mac_utilization_synth.rpt]
puts "Report: [file join $build_dir tiny_mac_utilization_synth.rpt]"
