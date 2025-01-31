//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
// This sequences randomizes the data_mem transaction and sends it 
// to the UVM driver.
//
// This sequence constructs and randomizes a data_mem_transaction.
// 
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class data_mem_random_sequence 
  extends data_mem_sequence_base ;

  `uvm_object_utils( data_mem_random_sequence )

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  //*****************************************************************
  function new(string name = "");
    super.new(name);
  endfunction: new

  // ****************************************************************************
  // TASK : body()
  // This task is automatically executed when this sequence is started using the 
  // start(sequencerHandle) task.
  //
  task body();
  
      // Construct the transaction
      req=data_mem_transaction::type_id::create("req");
      start_item(req);
      // Randomize the transaction
      if(!req.randomize()) `uvm_fatal("SEQ", "data_mem_random_sequence::body()-data_mem_transaction randomization failed")
      // Send the transaction to the data_mem_driver_bfm via the sequencer and data_mem_driver.
      finish_item(req);
      `uvm_info("SEQ", {"Response:",req.convert2string()},UVM_MEDIUM)

  endtask

endclass: data_mem_random_sequence

// pragma uvmf custom external begin
// pragma uvmf custom external end

