 

onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -noupdate -divider fetch_env_fet_in 
add wave -noupdate /uvm_root/uvm_test_top/environment.fetch_env/fet_in/fet_in_monitor/txn_stream
add wave -noupdate -group fetch_env_fet_in_bus /hdl_top/fetch_env_fet_in_bus/*
add wave -noupdate -divider fetch_env_fet_out 
add wave -noupdate /uvm_root/uvm_test_top/environment.fetch_env/fet_out/fet_out_monitor/txn_stream
add wave -noupdate -group fetch_env_fet_out_bus /hdl_top/fetch_env_fet_out_bus/*
add wave -noupdate -divider decode_env_dec_in 
add wave -noupdate /uvm_root/uvm_test_top/environment.decode_env/dec_in/dec_in_monitor/txn_stream
add wave -noupdate -group decode_env_dec_in_bus /hdl_top/decode_env_dec_in_bus/*
add wave -noupdate -divider decode_env_dec_out 
add wave -noupdate /uvm_root/uvm_test_top/environment.decode_env/dec_out/dec_out_monitor/txn_stream
add wave -noupdate -group decode_env_dec_out_bus /hdl_top/decode_env_dec_out_bus/*
add wave -noupdate -divider execute_env_execute_in_agent 
add wave -noupdate /uvm_root/uvm_test_top/environment.execute_env/execute_in_agent/execute_in_agent_monitor/txn_stream
add wave -noupdate -group execute_env_execute_in_agent_bus /hdl_top/execute_env_execute_in_agent_bus/*
add wave -noupdate -divider execute_env_execute_out_agent 
add wave -noupdate /uvm_root/uvm_test_top/environment.execute_env/execute_out_agent/execute_out_agent_monitor/txn_stream
add wave -noupdate -group execute_env_execute_out_agent_bus /hdl_top/execute_env_execute_out_agent_bus/*
add wave -noupdate -divider writeback_env_wb_in 
add wave -noupdate /uvm_root/uvm_test_top/environment.writeback_env/wb_in/wb_in_monitor/txn_stream
add wave -noupdate -group writeback_env_wb_in_bus /hdl_top/writeback_env_wb_in_bus/*
add wave -noupdate -divider writeback_env_wb_out 
add wave -noupdate /uvm_root/uvm_test_top/environment.writeback_env/wb_out/wb_out_monitor/txn_stream
add wave -noupdate -group writeback_env_wb_out_bus /hdl_top/writeback_env_wb_out_bus/*
add wave -noupdate -divider memaccess_env_agent_in 
add wave -noupdate /uvm_root/uvm_test_top/environment.memaccess_env/agent_in/agent_in_monitor/txn_stream
add wave -noupdate -group memaccess_env_agent_in_bus /hdl_top/memaccess_env_agent_in_bus/*
add wave -noupdate -divider memaccess_env_agent_out 
add wave -noupdate /uvm_root/uvm_test_top/environment.memaccess_env/agent_out/agent_out_monitor/txn_stream
add wave -noupdate -group memaccess_env_agent_out_bus /hdl_top/memaccess_env_agent_out_bus/*
add wave -noupdate -divider controller_env_controller_in_agent 
add wave -noupdate /uvm_root/uvm_test_top/environment.controller_env/controller_in_agent/controller_in_agent_monitor/txn_stream
add wave -noupdate -group controller_env_controller_in_agent_bus /hdl_top/controller_env_controller_in_agent_bus/*
add wave -noupdate -divider controller_env_controller_out_agent 
add wave -noupdate /uvm_root/uvm_test_top/environment.controller_env/controller_out_agent/controller_out_agent_monitor/txn_stream
add wave -noupdate -group controller_env_controller_out_agent_bus /hdl_top/controller_env_controller_out_agent_bus/*
add wave -noupdate -divider instr_mem_agent 
add wave -noupdate /uvm_root/uvm_test_top/environment/instr_mem_agent/instr_mem_agent_monitor/txn_stream
add wave -noupdate -group instr_mem_agent_bus /hdl_top/instr_mem_agent_bus/*
add wave -noupdate -divider dat_mem_agent 
add wave -noupdate /uvm_root/uvm_test_top/environment/dat_mem_agent/dat_mem_agent_monitor/txn_stream
add wave -noupdate -group dat_mem_agent_bus /hdl_top/dat_mem_agent_bus/*



TreeUpdate [SetDefaultTree]
quietly wave cursor active 0
configure wave -namecolwidth 472
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {27 ns} {168 ns}

