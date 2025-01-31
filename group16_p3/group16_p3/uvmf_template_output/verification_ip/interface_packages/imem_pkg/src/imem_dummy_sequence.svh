//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
// This sequences randomizes the imem transaction and sends it 
// to the UVM driver.
//
// This sequence constructs and randomizes a imem_transaction.
// 
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class imem_dummy_sequence extends imem_sequence_base ;

  `uvm_object_utils( imem_dummy_sequence )

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
      req=imem_transaction::type_id::create("req");
      start_item(req);

      // // Randomize the transaction
      // if(!req.randomize()) `uvm_fatal("SEQ", "imem_random_sequence::body()-imem_transaction randomization failed")

      // LD into ADD's src regs


      // Set transaction to be a simple ADD operation -- ADD R1, R0, 4
      req.instruction = 16'b0101_001_000_1_00100;

      // Send the transaction to the imem_driver_bfm via the sequencer and imem_driver.
      finish_item(req);
      `uvm_info("SEQ", {"Response:",req.convert2string()},UVM_MEDIUM)

  endtask

endclass: imem_dummy_sequence

// pragma uvmf custom external begin
// pragma uvmf custom external end

