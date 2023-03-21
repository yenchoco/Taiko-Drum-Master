# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a35tcpg236-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir {C:/Users/user/Desktop/NTHU/verilog/course project/final project/final_project/final_project.cache/wt} [current_project]
set_property parent.project_path {C:/Users/user/Desktop/NTHU/verilog/course project/final project/final_project/final_project.xpr} [current_project]
set_property XPM_LIBRARIES XPM_MEMORY [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_repo_paths {{c:/Users/user/Desktop/NTHU/verilog/course project/lab6/KeyboardSampleCode/KeyboardSampleCode/ip}} [current_project]
update_ip_catalog
set_property ip_output_repo {c:/Users/user/Desktop/NTHU/verilog/course project/final project/final_project/final_project.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files {{C:/Users/user/Desktop/NTHU/verilog/course project/final project/final_project/Background_2.coe}}
read_verilog -library xil_defaultlib {
  {C:/Users/user/Desktop/NTHU/verilog/course project/final project/final_project/clock_divider.v}
  {C:/Users/user/Desktop/NTHU/verilog/course project/final project/music_test/debounce.v}
  {C:/Users/user/Desktop/NTHU/verilog/course project/final project/music_test/keyboard_decoder.v}
  {C:/Users/user/Desktop/NTHU/verilog/course project/final project/final_project/mem_addr_gen.v}
  {C:/Users/user/Desktop/NTHU/verilog/course project/final project/music_test/music_jojo.v}
  {C:/Users/user/Desktop/NTHU/verilog/course project/final project/music_test/music_lihong.v}
  {C:/Users/user/Desktop/NTHU/verilog/course project/final project/music_test/note_gen.v}
  {C:/Users/user/Desktop/NTHU/verilog/course project/final project/music_test/onepulse.v}
  {C:/Users/user/Desktop/NTHU/verilog/course project/final project/music_test/player_control.v}
  {C:/Users/user/Desktop/NTHU/verilog/course project/final project/music_test/player_control2.v}
  {C:/Users/user/Desktop/NTHU/verilog/course project/final project/music_test/speaker_control.v}
  {C:/Users/user/Desktop/NTHU/verilog/course project/final project/final_project/vga.v}
  {C:/Users/user/Desktop/NTHU/verilog/course project/final project/final_project/top.v}
}
read_ip -quiet {{C:/Users/user/Desktop/NTHU/verilog/course project/final project/final_project/final_project.srcs/sources_1/ip/KeyboardCtrl_0/KeyboardCtrl_0.xci}}

read_ip -quiet {{C:/Users/user/Desktop/NTHU/verilog/course project/final project/final_project/final_project.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0.xci}}
set_property used_in_implementation false [get_files -all {{c:/Users/user/Desktop/NTHU/verilog/course project/final project/final_project/final_project.srcs/sources_1/ip/blk_mem_gen_0/blk_mem_gen_0_ooc.xdc}}]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/user/Desktop/NTHU/verilog/course project/final project/final_project/Basys3_Master.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/user/Desktop/NTHU/verilog/course project/final project/final_project/Basys3_Master.xdc}}]

read_xdc {{C:/Users/user/Desktop/NTHU/verilog/course project/final project/final_project/lab8_constrain.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/user/Desktop/NTHU/verilog/course project/final project/final_project/lab8_constrain.xdc}}]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top demo_2 -part xc7a35tcpg236-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef demo_2.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file demo_2_utilization_synth.rpt -pb demo_2_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
