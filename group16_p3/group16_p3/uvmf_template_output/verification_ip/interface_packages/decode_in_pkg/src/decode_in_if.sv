//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the decode_in interface signals.
//      It is instantiated once per decode_in bus.  Bus Functional Models, 
//      BFM's named decode_in_driver_bfm, are used to drive signals on the bus.
//      BFM's named decode_in_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(decode_in_bus.npc_in), // Agent output 
// .dut_signal_port(decode_in_bus.enable_decode), // Agent output 
// .dut_signal_port(decode_in_bus.psr), // Agent output 
// .dut_signal_port(decode_in_bus.instr_dout), // Agent output 

import uvmf_base_pkg_hdl::*;
import decode_in_pkg_hdl::*;

interface  decode_in_if 

  (
  input tri clock, 
  input tri reset,
  inout tri [15:0] npc_in,
  inout tri  enable_decode,
  inout tri [2:0] psr,
  inout tri [15:0] instr_dout
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input npc_in,
  input enable_decode,
  input psr,
  input instr_dout
  );

modport initiator_port 
  (
  input clock,
  input reset,
  output npc_in,
  output enable_decode,
  output psr,
  output instr_dout
  );

modport responder_port 
  (
  input clock,
  input reset,  
  input npc_in,
  input enable_decode,
  input psr,
  input instr_dout
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

