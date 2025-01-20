//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
//
// DESCRIPTION: This analysis component contains analysis_exports for receiving
//   data and analysis_ports for sending data.
// 
//   This analysis component has the following analysis_exports that receive the 
//   listed transaction type.
//   
//   analysis_export receives transactions of type  controller_in_transaction
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  analysis_port broadcasts transactions of type controller_out_transaction
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class controller_predictor #(
  type CONFIG_T,
  type BASE_T = uvm_component
  )
 extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( controller_predictor #(
                              CONFIG_T,
                              BASE_T
                              )
)


  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_analysis_export #(controller_in_transaction, controller_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )
) analysis_export;

  
  // Instantiate the analysis ports
  uvm_analysis_port #(controller_out_transaction) analysis_port;


  // Transaction variable for predicted values to be sent out analysis_port
  // Once a transaction is sent through an analysis_port, another transaction should
  // be constructed for the next predicted transaction. 
  typedef controller_out_transaction analysis_port_output_transaction_t;
  analysis_port_output_transaction_t analysis_port_output_transaction;
  // Code for sending output transaction out through analysis_port
  // analysis_port.write(analysis_port_output_transaction);

  // Define transaction handles for debug visibility 
  controller_in_transaction analysis_export_debug;
  bit c_model_output;


  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  // FUNCTION: new
  function new(string name, uvm_component parent);
     super.new(name,parent);
 //   `uvm_warning("PREDICTOR_REVIEW", "This predictor has been created either through generation or re-generation with merging.  Remove this warning after the predictor has been reviewed.")
  // pragma uvmf custom new begin
  // pragma uvmf custom new end
  endfunction

  // FUNCTION: build_phase
  virtual function void build_phase (uvm_phase phase);

    analysis_export = new("analysis_export", this);
    analysis_port =new("analysis_port", this );
  // pragma uvmf custom build_phase begin
  // pragma uvmf custom build_phase end
  endfunction

  // FUNCTION: write_analysis_export
  // Transactions received through analysis_export initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_analysis_export(controller_in_transaction t);
    // pragma uvmf custom analysis_export_predictor begin
    analysis_export_debug = t;
    `uvm_info("PRED", "Transaction Received through analysis_export", UVM_MEDIUM)
    `uvm_info("PRED", {"            Data: ",t.convert2string()}, UVM_FULL)
    // Construct one of each output transaction type.
    analysis_port_output_transaction = analysis_port_output_transaction_t::type_id::create("analysis_port_output_transaction");
    //  UVMF_CHANGE_ME: Implement predictor model here.  
    // `uvm_info("UNIMPLEMENTED_PREDICTOR_MODEL", "******************************************************************************************************",UVM_NONE)
    // `uvm_info("UNIMPLEMENTED_PREDICTOR_MODEL", "UVMF_CHANGE_ME: The controller_predictor::write_analysis_export function needs to be completed with DUT prediction model",UVM_NONE)
    // `uvm_info("UNIMPLEMENTED_PREDICTOR_MODEL", "******************************************************************************************************",UVM_NONE)
    c_model_output = controller_model(
        .complete_data(t.complete_data),
        .complete_instr(t.complete_instr),
        .IR(t.IR),
        .psr(t.psr),
        .IR_Exec(t.IR_Exec),
        .IMem_dout(t.IMem_dout),
        .NZP(t.NZP),
        .enable_updatePC(analysis_port_output_transaction.enable_updatePC),
        .enable_fetch(analysis_port_output_transaction.enable_fetch),
        .enable_decode(analysis_port_output_transaction.enable_decode),
        .enable_execute(analysis_port_output_transaction.enable_execute),
        .enable_writeback(analysis_port_output_transaction.enable_writeback),
        .bypass_alu_1(analysis_port_output_transaction.bypass_alu_1),
        .bypass_alu_2(analysis_port_output_transaction.bypass_alu_2),
        .bypass_mem_1(analysis_port_output_transaction.bypass_mem_1),
        .bypass_mem_2(analysis_port_output_transaction.bypass_mem_2),
        .mem_state(analysis_port_output_transaction.mem_state),
        .br_taken(analysis_port_output_transaction.br_taken)
    );
    // Code for sending output transaction out through analysis_port
    // Please note that each broadcasted transaction should be a different object than previously 
    // broadcasted transactions.  Creation of a different object is done by constructing the transaction 
    // using either new() or create().  Broadcasting a transaction object more than once to either the 
    // same subscriber or multiple subscribers will result in unexpected and incorrect behavior.
    if(c_model_output==0)begin
      analysis_port.write(analysis_port_output_transaction);
    end
    // pragma uvmf custom analysis_export_predictor end
  endfunction


endclass 

// pragma uvmf custom external begin
// pragma uvmf custom external end

