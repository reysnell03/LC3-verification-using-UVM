//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This environment contains all agents, predictors and
// scoreboards required for the block level design.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class fetch_environment  extends uvmf_environment_base #(
    .CONFIG_T( fetch_env_configuration 
  ));
  `uvm_component_utils( fetch_environment )





  typedef fetch_in_agent  fet_in_t;
  fet_in_t fet_in;

  typedef fetch_out_agent  fet_out_t;
  fet_out_t fet_out;




  typedef fetch_predictor #(
                .CONFIG_T(CONFIG_T)
                )
 fet_pred_t;
  fet_pred_t fet_pred;

  typedef uvmf_in_order_scoreboard #(.T(fetch_out_transaction))  fet_sb_t;
  fet_sb_t fet_sb;



  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(fetch_env_configuration)) fetch_vsqr_t;
  fetch_vsqr_t vsqr;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
 
// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

// ****************************************************************************
// FUNCTION: build_phase()
// This function builds all components within this environment.
//
  virtual function void build_phase(uvm_phase phase);
// pragma uvmf custom build_phase_pre_super begin
// pragma uvmf custom build_phase_pre_super end
    super.build_phase(phase);
    fet_in = fet_in_t::type_id::create("fet_in",this);
    fet_in.set_config(configuration.fet_in_config);
    fet_out = fet_out_t::type_id::create("fet_out",this);
    fet_out.set_config(configuration.fet_out_config);
    fet_pred = fet_pred_t::type_id::create("fet_pred",this);
    fet_pred.configuration = configuration;
    fet_sb = fet_sb_t::type_id::create("fet_sb",this);
    fet_sb.end_of_test_empty_check = 0; //Additional 10 errors
    vsqr = fetch_vsqr_t::type_id::create("vsqr", this);
    vsqr.set_config(configuration);
    configuration.set_vsqr(vsqr);
    fet_sb.set_report_severity_id_override(UVM_WARNING, "SCBD", UVM_INFO);
    
    // pragma uvmf custom build_phase begin
    // pragma uvmf custom build_phase end
  endfunction

// ****************************************************************************
// FUNCTION: connect_phase()
// This function makes all connections within this environment.  Connections
// typically inclue agent to predictor, predictor to scoreboard and scoreboard
// to agent.
//
  virtual function void connect_phase(uvm_phase phase);
// pragma uvmf custom connect_phase_pre_super begin
// pragma uvmf custom connect_phase_pre_super end
    super.connect_phase(phase);
    fet_in.monitored_ap.connect(fet_pred.fet_in_agent_ae);
    fet_pred.fet_sb_ap.connect(fet_sb.expected_analysis_export);
    fet_out.monitored_ap.connect(fet_sb.actual_analysis_export);
    // pragma uvmf custom reg_model_connect_phase begin
    // pragma uvmf custom reg_model_connect_phase end
  endfunction

// ****************************************************************************
// FUNCTION: end_of_simulation_phase()
// This function is executed just prior to executing run_phase.  This function
// was added to the environment to sample environment configuration settings
// just before the simulation exits time 0.  The configuration structure is 
// randomized in the build phase before the environment structure is constructed.
// Configuration variables can be customized after randomization in the build_phase
// of the extended test.
// If a sequence modifies values in the configuration structure then the sequence is
// responsible for sampling the covergroup in the configuration if required.
//
  virtual function void start_of_simulation_phase(uvm_phase phase);
     configuration.fetch_configuration_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

