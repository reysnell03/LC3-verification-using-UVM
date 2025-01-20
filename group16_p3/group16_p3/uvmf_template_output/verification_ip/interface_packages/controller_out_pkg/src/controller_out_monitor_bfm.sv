//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface performs the controller_out signal monitoring.
//      It is accessed by the uvm controller_out monitor through a virtual
//      interface handle in the controller_out configuration.  It monitors the
//      signals passed in through the port connection named bus of
//      type controller_out_if.
//
//     Input signals from the controller_out_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//      Interface functions and tasks used by UVM components:
//             monitor(inout TRANS_T txn);
//                   This task receives the transaction, txn, from the
//                   UVM monitor and then populates variables in txn
//                   from values observed on bus activity.  This task
//                   blocks until an operation on the controller_out bus is complete.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import controller_out_pkg_hdl::*;
`include "src/controller_out_macros.svh"


interface controller_out_monitor_bfm 
  ( controller_out_if  bus );
  // The pragma below and additional ones in-lined further down are for running this BFM on Veloce
  // pragma attribute controller_out_monitor_bfm partition_interface_xif                                  

`ifndef XRTL
// This code is to aid in debugging parameter mismatches between the BFM and its corresponding agent.
// Enable this debug by setting UVM_VERBOSITY to UVM_DEBUG
// Setting UVM_VERBOSITY to UVM_DEBUG causes all BFM's and all agents to display their parameter settings.
// All of the messages from this feature have a UVM messaging id value of "CFG"
// The transcript or run.log can be parsed to ensure BFM parameter settings match its corresponding agents parameter settings.
import uvm_pkg::*;
`include "uvm_macros.svh"
initial begin : bfm_vs_agent_parameter_debug
  `uvm_info("CFG", 
      $psprintf("The BFM at '%m' has the following parameters: ", ),
      UVM_DEBUG)
end
`endif


  // Structure used to pass transaction data from monitor BFM to monitor class in agent.
`controller_out_MONITOR_STRUCT
  controller_out_monitor_s controller_out_monitor_struct;

  // Structure used to pass configuration data from monitor class to monitor BFM.
 `controller_out_CONFIGURATION_STRUCT
 

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri clock_i;
  tri reset_i;
  tri  enable_updatePC_i;
  tri  enable_fetch_i;
  tri  enable_decode_i;
  tri  enable_execute_i;
  tri  enable_writeback_i;
  tri  br_taken_i;
  tri  bypass_alu_1_i;
  tri  bypass_alu_2_i;
  tri  bypass_mem_1_i;
  tri  bypass_mem_2_i;
  tri [1:0] mem_state_i;
  assign clock_i = bus.clock;
  assign reset_i = bus.reset;
  assign enable_updatePC_i = bus.enable_updatePC;
  assign enable_fetch_i = bus.enable_fetch;
  assign enable_decode_i = bus.enable_decode;
  assign enable_execute_i = bus.enable_execute;
  assign enable_writeback_i = bus.enable_writeback;
  assign br_taken_i = bus.br_taken;
  assign bypass_alu_1_i = bus.bypass_alu_1;
  assign bypass_alu_2_i = bus.bypass_alu_2;
  assign bypass_mem_1_i = bus.bypass_mem_1;
  assign bypass_mem_2_i = bus.bypass_mem_2;
  assign mem_state_i = bus.mem_state;

  // Proxy handle to UVM monitor
  controller_out_pkg::controller_out_monitor  proxy;
  // pragma tbx oneway proxy.notify_transaction                 

  // pragma uvmf custom interface_item_additional begin
  // pragma uvmf custom interface_item_additional end
  
  //******************************************************************                         
  task wait_for_reset();// pragma tbx xtf  
    @(posedge clock_i) ;                                                                    
    do_wait_for_reset();                                                                   
  endtask                                                                                   

  // ****************************************************************************              
  task do_wait_for_reset(); 
  // pragma uvmf custom reset_condition begin
    wait ( reset_i === 0 ) ;                                                              
    @(posedge clock_i) ;                                                                    
  // pragma uvmf custom reset_condition end                                                                
  endtask    

  //******************************************************************                         
 
  task wait_for_num_clocks(input int unsigned count); // pragma tbx xtf 
    @(posedge clock_i);  
                                                                   
    repeat (count-1) @(posedge clock_i);                                                    
  endtask      

  //******************************************************************                         
  event go;                                                                                 
  function void start_monitoring();// pragma tbx xtf    
    -> go;
  endfunction                                                                               
  
  // ****************************************************************************              
  initial begin                                                                             
    @go;         
    wait_for_reset();                                                                           
    forever begin                                                                        
      @(posedge clock_i);  
      do_monitor( controller_out_monitor_struct );
                                                                 
 
      proxy.notify_transaction( controller_out_monitor_struct );
 
    end                                                                                    
  end                                                                                       

  //******************************************************************
  // The configure() function is used to pass agent configuration
  // variables to the monitor BFM.  It is called by the monitor within
  // the agent at the beginning of the simulation.  It may be called 
  // during the simulation if agent configuration variables are updated
  // and the monitor BFM needs to be aware of the new configuration 
  // variables.
  //
    function void configure(controller_out_configuration_s controller_out_configuration_arg); // pragma tbx xtf  
    initiator_responder = controller_out_configuration_arg.initiator_responder;
  // pragma uvmf custom configure begin
  // pragma uvmf custom configure end
  endfunction   


  // ****************************************************************************  
            
  task do_monitor(output controller_out_monitor_s controller_out_monitor_struct);
    //
    // Available struct members:
    //     //    controller_out_monitor_struct.enable_updatePC
    //     //    controller_out_monitor_struct.enable_fetch
    //     //    controller_out_monitor_struct.enable_decode
    //     //    controller_out_monitor_struct.enable_execute
    //     //    controller_out_monitor_struct.enable_writeback
    //     //    controller_out_monitor_struct.br_taken
    //     //    controller_out_monitor_struct.bypass_alu_1
    //     //    controller_out_monitor_struct.bypass_alu_2
    //     //    controller_out_monitor_struct.bypass_mem_1
    //     //    controller_out_monitor_struct.bypass_mem_2
    //     //    controller_out_monitor_struct.mem_state
    //     //    controller_out_monitor_struct.start_time
    //     //    controller_out_monitor_struct.end_time
    //     //    controller_out_monitor_struct.transaction_view_h
    //     //
    // Reference code;
    //    How to wait for signal value
    //      while (control_signal === 1'b1) @(posedge clock_i);
    //    
    //    How to assign a struct member, named xyz, from a signal.   
    //    All available input signals listed.
    //      controller_out_monitor_struct.xyz = enable_updatePC_i;  //     
    //      controller_out_monitor_struct.xyz = enable_fetch_i;  //     
    //      controller_out_monitor_struct.xyz = enable_decode_i;  //     
    //      controller_out_monitor_struct.xyz = enable_execute_i;  //     
    //      controller_out_monitor_struct.xyz = enable_writeback_i;  //     
    //      controller_out_monitor_struct.xyz = br_taken_i;  //     
    //      controller_out_monitor_struct.xyz = bypass_alu_1_i;  //     
    //      controller_out_monitor_struct.xyz = bypass_alu_2_i;  //     
    //      controller_out_monitor_struct.xyz = bypass_mem_1_i;  //     
    //      controller_out_monitor_struct.xyz = bypass_mem_2_i;  //     
    //      controller_out_monitor_struct.xyz = mem_state_i;  //    [1:0] 
    // pragma uvmf custom do_monitor begin
    // UVMF_CHANGE_ME : Implement protocol monitoring.  The commented reference code 
    // below are examples of how to capture signal values and assign them to 
    // structure members.  All available input signals are listed.  The 'while' 
    // code example shows how to wait for a synchronous flow control signal.  This
    // task should return when a complete transfer has been observed.  Once this task is
    // exited with captured values, it is then called again to wait for and observe 
    // the next transfer. One clock cycle is consumed between calls to do_monitor.
   // @(posedge clock_i);
   // @(posedge clock_i);
   // @(posedge clock_i);
  //  @(posedge clock_i);
  controller_out_monitor_struct.enable_updatePC = enable_updatePC_i; 
   controller_out_monitor_struct.enable_fetch = enable_fetch_i; 
   controller_out_monitor_struct.enable_decode = enable_decode_i; 
   controller_out_monitor_struct.enable_execute = enable_execute_i; 
   controller_out_monitor_struct.enable_writeback = enable_writeback_i;  
   controller_out_monitor_struct.br_taken = br_taken_i; 
   controller_out_monitor_struct.bypass_alu_1 = bypass_alu_1_i; 
   controller_out_monitor_struct.bypass_alu_2 = bypass_alu_2_i; 
   controller_out_monitor_struct.bypass_mem_1 = bypass_mem_1_i; 
   controller_out_monitor_struct.bypass_mem_2 = bypass_mem_2_i; 
   controller_out_monitor_struct.mem_state = mem_state_i; 

    // pragma uvmf custom do_monitor end
  endtask         
  
 
endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

