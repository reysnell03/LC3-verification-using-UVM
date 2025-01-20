//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This test extends test_top and makes 
//    changes to test_top using the UVM factory type_override:
//
//    Test scenario: 
//      This is a template test that can be used to create future tests.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

 class dummy_test extends test_top;

  `uvm_component_utils( dummy_test );

  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

  virtual function void build_phase(uvm_phase phase);
    // The factory override below is an example of how to replace the lc3_bench_sequence_base 
    // sequence with the example_derived_test_sequence.
    imem_responder_sequence::type_id::set_type_override(imem_alu_responder_sequence::get_type());
    //lc3_bench_sequence_base::type_id::set_type_override(lc3_dummy_derived_test_sequence::get_type());
    
    // Execute the build_phase of test_top AFTER all factory overrides have been created.
    super.build_phase(phase);
    // pragma uvmf custom configuration_settings_post_randomize begin
    // UVMF_CHANGE_ME Test specific configuration values can be set here.  
    // The configuration structure has already been randomized.
    // pragma uvmf custom configuration_settings_post_randomize end
  endfunction

endclass

class control_test extends test_top;

  `uvm_component_utils( control_test );

  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

  virtual function void build_phase(uvm_phase phase);
    // The factory override below is an example of how to replace the lc3_bench_sequence_base 
    // sequence with the example_derived_test_sequence.
    imem_responder_sequence::type_id::set_type_override(imem_ctrl_switch_responder_sequence::get_type());
    //lc3_bench_sequence_base::type_id::set_type_override(lc3_dummy_derived_test_sequence::get_type());
    
    // Execute the build_phase of test_top AFTER all factory overrides have been created.
    super.build_phase(phase);
    // pragma uvmf custom configuration_settings_post_randomize begin
    // UVMF_CHANGE_ME Test specific configuration values can be set here.  
    // The configuration structure has already been randomized.
    // pragma uvmf custom configuration_settings_post_randomize end
  endfunction

endclass


class mem_test extends test_top;

  `uvm_component_utils( mem_test );

  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

  virtual function void build_phase(uvm_phase phase);
    // The factory override below is an example of how to replace the lc3_bench_sequence_base 
    // sequence with the example_derived_test_sequence.
    imem_responder_sequence::type_id::set_type_override(imem_mem_responder_sequence::get_type());
    //lc3_bench_sequence_base::type_id::set_type_override(lc3_dummy_derived_test_sequence::get_type());
    
    // Execute the build_phase of test_top AFTER all factory overrides have been created.
    super.build_phase(phase);
    // pragma uvmf custom configuration_settings_post_randomize begin
    // UVMF_CHANGE_ME Test specific configuration values can be set here.  
    // The configuration structure has already been randomized.
    // pragma uvmf custom configuration_settings_post_randomize end
  endfunction

endclass


class misc_test extends test_top;

  `uvm_component_utils( misc_test );

  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

  virtual function void build_phase(uvm_phase phase);
    // The factory override below is an example of how to replace the lc3_bench_sequence_base 
    // sequence with the example_derived_test_sequence.
    imem_responder_sequence::type_id::set_type_override(imem_misc_responder_sequence::get_type());
    //lc3_bench_sequence_base::type_id::set_type_override(lc3_dummy_derived_test_sequence::get_type());
    
    // Execute the build_phase of test_top AFTER all factory overrides have been created.
    super.build_phase(phase);
    // pragma uvmf custom configuration_settings_post_randomize begin
    // UVMF_CHANGE_ME Test specific configuration values can be set here.  
    // The configuration structure has already been randomized.
    // pragma uvmf custom configuration_settings_post_randomize end
  endfunction

endclass

class mem_coverage extends test_top;

  `uvm_component_utils( mem_coverage );

  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

  virtual function void build_phase(uvm_phase phase);
    // The factory override below is an example of how to replace the lc3_bench_sequence_base 
    // sequence with the example_derived_test_sequence.
    imem_responder_sequence::type_id::set_type_override(imem_mem_coverage_responder_sequence::get_type());
    //lc3_bench_sequence_base::type_id::set_type_override(lc3_dummy_derived_test_sequence::get_type());
    
    // Execute the build_phase of test_top AFTER all factory overrides have been created.
    super.build_phase(phase);
    // pragma uvmf custom configuration_settings_post_randomize begin
    // UVMF_CHANGE_ME Test specific configuration values can be set here.  
    // The configuration structure has already been randomized.
    // pragma uvmf custom configuration_settings_post_randomize end
  endfunction

endclass

class ld_st_coverage extends test_top;

  `uvm_component_utils( ld_st_coverage );

  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

  virtual function void build_phase(uvm_phase phase);
    // The factory override below is an example of how to replace the lc3_bench_sequence_base 
    // sequence with the example_derived_test_sequence.
    imem_responder_sequence::type_id::set_type_override(imem_ld_st_coverage_responder_sequence::get_type());
    //lc3_bench_sequence_base::type_id::set_type_override(lc3_dummy_derived_test_sequence::get_type());
    
    // Execute the build_phase of test_top AFTER all factory overrides have been created.
    super.build_phase(phase);
    // pragma uvmf custom configuration_settings_post_randomize begin
    // UVMF_CHANGE_ME Test specific configuration values can be set here.  
    // The configuration structure has already been randomized.
    // pragma uvmf custom configuration_settings_post_randomize end
  endfunction

endclass

class ldr_str_coverage extends test_top;

  `uvm_component_utils( ldr_str_coverage );

  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

  virtual function void build_phase(uvm_phase phase);
    // The factory override below is an example of how to replace the lc3_bench_sequence_base 
    // sequence with the example_derived_test_sequence.
    imem_responder_sequence::type_id::set_type_override(imem_ldr_str_coverage_responder_sequence::get_type());
    //lc3_bench_sequence_base::type_id::set_type_override(lc3_dummy_derived_test_sequence::get_type());
    
    // Execute the build_phase of test_top AFTER all factory overrides have been created.
    super.build_phase(phase);
    // pragma uvmf custom configuration_settings_post_randomize begin
    // UVMF_CHANGE_ME Test specific configuration values can be set here.  
    // The configuration structure has already been randomized.
    // pragma uvmf custom configuration_settings_post_randomize end
  endfunction

endclass

class control_test_2 extends test_top;
  `uvm_component_utils( control_test_2 );
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction
  virtual function void build_phase(uvm_phase phase);
    imem_responder_sequence::type_id::set_type_override(imem_ld_st_coverage_responder_sequence::get_type());
    super.build_phase(phase);
  endfunction
endclass

class mem_test_2 extends test_top;
  `uvm_component_utils( mem_test_2 );
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction
  virtual function void build_phase(uvm_phase phase);
    imem_responder_sequence::type_id::set_type_override(imem_ldr_str_coverage_responder_sequence::get_type());
    super.build_phase(phase);
  endfunction
endclass
class alu_test_2 extends test_top;
  `uvm_component_utils( alu_test_2 );
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction
  virtual function void build_phase(uvm_phase phase);
    imem_responder_sequence::type_id::set_type_override(imem_alu_responder_sequence::get_type());
    super.build_phase(phase);
  endfunction
endclass

class mem_cov_test_2 extends test_top;
  `uvm_component_utils( mem_cov_test_2 );
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction
  virtual function void build_phase(uvm_phase phase);
    imem_responder_sequence::type_id::set_type_override(imem_mem_coverage_responder_sequence::get_type());
    super.build_phase(phase);
  endfunction
endclass

//-----------------------------------------------------------------------------------