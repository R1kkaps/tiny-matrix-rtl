# Generate the project first with create_project.tcl.
set script_dir [file dirname [file normalize [info script]]]
set build_dir [file join $script_dir build]
set sim_log [file join $build_dir tiny_mac.sim sim_1 behav xsim simulate.log]

open_project [file join $build_dir tiny_mac.xpr]

foreach tb {mul8_tb mac_tb dot2_tb matrix2x2_tb} {
    set_property top $tb [get_filesets sim_1]
    update_compile_order -fileset sim_1
    launch_simulation -simset sim_1 -mode behavioral
    close_sim

    if {![file exists $sim_log]} {
        error "No simulation log found for $tb"
    }
    set handle [open $sim_log r]
    set output [read $handle]
    close $handle

    if {[string first "PASS $tb" $output] < 0 || [string first "FAIL " $output] >= 0} {
        error "Testbench $tb did not pass; see $sim_log"
    }
    puts "PASS $tb"
}

set_property top matrix2x2_tb [get_filesets sim_1]
update_compile_order -fileset sim_1
puts "All four testbenches passed."
