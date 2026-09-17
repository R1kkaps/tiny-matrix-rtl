# Run from any directory with: vivado -mode batch -source vivado/create_project.tcl
set script_dir [file dirname [file normalize [info script]]]
set root_dir [file dirname $script_dir]
set build_dir [file join $script_dir build]

create_project tiny_mac $build_dir -part xc7a200tfbg676-2 -force
set_property target_language Verilog [current_project]

set rtl_files [list \
    [file join $root_dir rtl mul8.v] \
    [file join $root_dir rtl mac.v] \
    [file join $root_dir rtl dot2.v] \
    [file join $root_dir rtl matrix2x2.v]]
set tb_files [list \
    [file join $root_dir tb mul8_tb.v] \
    [file join $root_dir tb mac_tb.v] \
    [file join $root_dir tb dot2_tb.v] \
    [file join $root_dir tb matrix2x2_tb.v]]

add_files -fileset sources_1 -norecurse $rtl_files
add_files -fileset sim_1 -norecurse $tb_files
set_property top matrix2x2 [get_filesets sources_1]
set_property top matrix2x2_tb [get_filesets sim_1]
update_compile_order -fileset sources_1
update_compile_order -fileset sim_1
puts "Created [file join $build_dir tiny_mac.xpr]"
