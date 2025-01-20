//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class can be used to provide stimulus when an interface
//              has been configured to run in a responder mode. It
//              will never finish by default, always going back to the driver
//              and driver BFM for the next transaction with which to respond.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class imem_responder_sequence 
  extends imem_sequence_base ;

  `uvm_object_utils( imem_responder_sequence )
    int count = -1;
  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_responder_sequence");
    super.new(name);
  endfunction

  task body();
    req=imem_transaction::type_id::create("req");
    //forever begin 
    repeat(sequence_runs) begin
      start_item(req);
      if(count == 0) assert(req.randomize() with {opcode == BR; n == 1'b0 ; z == 1'b1 ; p == 1'b0;});
      else if(count >= 1  && count < 9 )assert(req.randomize() with {opcode == LD ; dr == count-1;});
      else if(count >= 9 && count < 17) assert(req.randomize() with {opcode == ST ; sr1 == count - 9;});
      else if(count >= 17 && count < 27)assert(req.randomize() with {opcode inside {ADD,AND,NOT};});
      else if(count >= 27 && count < 37)assert(req.randomize() with {opcode inside {BR,JMP};});
      else if(count >= 37 && count < 47)assert(req.randomize() with {opcode inside {LD,LDR,LDI,LEA,ST,STR,STI};});
      else assert(req.randomize());
      finish_item(req);
      count  = count + 1;
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
      // pragma uvmf custom body end
    end
  endtask

endclass


class imem_alu_responder_sequence 
  extends imem_responder_sequence ;

  `uvm_object_utils( imem_alu_responder_sequence )

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_alu_responder_sequence");
    super.new(name);
  endfunction

  task body();
    int count = -1;
    req=imem_transaction::type_id::create("req");
    repeat(sequence_runs) begin           
      start_item(req);
      if(count ==0) assert(req.randomize() with {opcode == BR; n == 1'b1 ; z == 1'b1 ; p == 1'b1;});
      else if(count >= 1  && count < 9)assert(req.randomize() with {opcode == LD ; dr == count-1; });
      else if(count >= 9 && count < 17) assert(req.randomize() with {opcode == ST ; sr1 == count - 9;});
      else assert(req.randomize() with {opcode inside {ADD,AND,NOT};});
      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the alu_responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
      count++;
      // pragma uvmf custom body end
    end
  endtask

endclass

class imem_misc_responder_sequence 
  extends imem_responder_sequence ;

  `uvm_object_utils( imem_misc_responder_sequence )

  // pragma uvmf custom class_item_additional begin
  int count = -1;
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_misc_responder_sequence");
    super.new(name);
  endfunction

  task body();
    req=imem_transaction::type_id::create("req");
    repeat(sequence_runs) begin
      start_item(req);
      if(count ==0) assert(req.randomize() with {opcode == BR; n == 1'b1 ; z == 1'b1 ; p == 1'b1;});
      else if(count >=1  && count < 9 )assert(req.randomize() with {opcode == LD ; dr == count-1; });
      else if(count >= 9 && count < 17) assert(req.randomize() with {opcode == ST ; sr1 == count - 9;});
      else if(count == 17)assert(req.randomize() with {opcode == JMP; baser == 3'b0;});
      else assert(req.randomize() with {sr1 == sr2; dr == sr2; baser == sr2;});
      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the misc_responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
      count  = count + 1;
      // pragma uvmf custom body end
    end
  endtask

endclass
// pragma uvmf custom external begin
// pragma uvmf custom external end

class imem_mem_coverage_responder_sequence 
  extends imem_responder_sequence ;

  `uvm_object_utils( imem_mem_coverage_responder_sequence )

  // pragma uvmf custom class_item_additional begin
  int count = 0;
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_mem_coverage_responder_sequence");
    super.new(name);
  endfunction

  task body();
    req=imem_transaction::type_id::create("req");
    repeat(sequence_runs) begin
      start_item(req);

      if (count % 2 == 0) assert(req.randomize() with {opcode inside {LD, ST};});
      else assert(req.randomize() with {opcode == BR;});

      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the raw_responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
      count  = count + 1;
      // pragma uvmf custom body end
    end
  endtask

endclass

class imem_ctrl_switch_responder_sequence 
  extends imem_responder_sequence ;

  `uvm_object_utils( imem_ctrl_switch_responder_sequence )

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_ctrl_switch_responder_sequence");
    super.new(name);
  endfunction

  task body();
    int count = -1;
    req=imem_transaction::type_id::create("req");
    repeat(sequence_runs) begin           
      start_item(req);
      if(count == 0) assert(req.randomize() with {opcode == BR; n == 1'b1 ; z == 1'b1 ; p == 1'b1;});
      else if(count >=1 && count < 9)assert(req.randomize() with {opcode == LD ; dr == count-1; });
      else if(count >= 9 && count < 17) assert(req.randomize() with {opcode == ST ; sr1 == count - 9;});
      else if (count >=240)assert(req.randomize() with {opcode inside {AND,ADD,NOT};});
      else assert(req.randomize() with {opcode inside {BR,JMP};});
      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the ctrl_switch_responder sequence.
      // If this was an item that required a ctrl_switch_response, the expectation is
      // that the ctrl_switch_response should be populated within this transaction now.
      `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
      count++;
      // pragma uvmf custom body end
    end
  endtask

endclass

class imem_mem_responder_sequence 
  extends imem_responder_sequence ;

  `uvm_object_utils( imem_mem_responder_sequence )

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_mem_responder_sequence");
    super.new(name);
  endfunction

  virtual task body();
    int count = -1;
    req=imem_transaction::type_id::create("req");
    repeat(sequence_runs) begin           
      start_item(req);
      if(count == 0) assert(req.randomize() with {opcode == BR; n == 1'b1 ; z == 1'b1 ; p == 1'b1;});
      else if(count >=1 && count < 9)assert(req.randomize() with {opcode == LD ; dr == count-1; });
      else if(count >= 9 && count < 17) assert(req.randomize() with {opcode == ST ; sr1 == count - 9;});
      else assert(req.randomize() with {opcode inside {LD,LDR,LDI,LEA,ST,STR,STI};});
      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the mem_responder sequence.
      // If this was an item that required a mem_response, the expectation is
      // that the mem_response should be populated within this transaction now.
      `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
      count++;
      // pragma uvmf custom body end
    end
  endtask

endclass

class imem_ld_st_coverage_responder_sequence 
  extends imem_responder_sequence ;

  `uvm_object_utils( imem_ld_st_coverage_responder_sequence )

  // pragma uvmf custom class_item_additional begin
  int count = 0;
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_ld_st_coverage_responder_sequence");
    super.new(name);
  endfunction

  task body();
    req=imem_transaction::type_id::create("req");
    repeat(sequence_runs * 1.5) begin
      start_item(req);

      if (count % 3 == 1 || count % 3 == 2) assert(req.randomize() with {opcode inside {LD, LDI, LEA};});
      else assert(req.randomize() with {opcode inside {ST, STI};});

      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the raw_responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
      count  = count + 1;
      // pragma uvmf custom body end
    end
  endtask

endclass

class imem_ldr_str_coverage_responder_sequence 
  extends imem_responder_sequence ;

  `uvm_object_utils( imem_ldr_str_coverage_responder_sequence )

  // pragma uvmf custom class_item_additional begin
  int count = 0;
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_ldr_str_coverage_responder_sequence");
    super.new(name);
  endfunction

  task body();
    req=imem_transaction::type_id::create("req");
    repeat(sequence_runs) begin
      start_item(req);

    // Loads all regs first
      if(count >= 1  && count < 9 )assert(req.randomize() with {opcode == LD ; dr == count-1; });
      else assert(req.randomize() with {opcode inside {LDR, STR};});

      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the raw_responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
      count  = count + 1;
      // pragma uvmf custom body end
    end
  endtask

endclass

//---------------------------------------------------------------------------------------------