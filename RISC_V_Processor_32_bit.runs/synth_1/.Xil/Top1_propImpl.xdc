set_property SRC_FILE_INFO {cfile:D:/RTL_Design/RISC_V_Processor_32_bit/RISC_V_Processor_32_bit.srcs/constrs_1/new/RISC_const.xdc rfile:../../../RISC_V_Processor_32_bit.srcs/constrs_1/new/RISC_const.xdc id:1} [current_design]
set_property src_info {type:XDC file:1 line:2 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN W5 [get_ports clk]
set_property src_info {type:XDC file:1 line:4 export:INPUT save:INPUT read:READ} [current_design]
create_clock -period 10.000 [get_ports clk]   # 100 MHz
set_property src_info {type:XDC file:1 line:7 export:INPUT save:INPUT read:READ} [current_design]
set_property PACKAGE_PIN U18 [get_ports reset]
