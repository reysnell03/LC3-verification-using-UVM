//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class records imem transaction information using
//       a covergroup named imem_transaction_cg.  An instance of this
//       coverage component is instantiated in the uvmf_parameterized_agent
//       if the has_coverage flag is set.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class imem_transaction_coverage  extends uvm_subscriber #(.T(imem_transaction ));

  `uvm_component_utils( imem_transaction_coverage )

  T coverage_trans;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
     T t_cov, prev_t_cov;
     bit first = 1'b1;
     bit alu,ld,str,flow_switch;
  // ****************************************************************************
  covergroup imem_transaction_cg;
    // pragma uvmf custom covergroup begin
    // UVMF_CHANGE_ME : Add coverage bins, crosses, exclusions, etc. according to coverage needs.
    option.auto_bin_max=1024;
    option.per_instance=1;
    // opcode: coverpoint coverage_trans.opcode;
    // sr1: coverpoint coverage_trans.sr1;
    // sr2: coverpoint coverage_trans.sr2;
    // dr: coverpoint coverage_trans.dr;
    // baser: coverpoint coverage_trans.baser;
    // pcoffset9: coverpoint coverage_trans.pcoffset9;
    // pcoffset6: coverpoint coverage_trans.pcoffset6;
    // imm5: coverpoint coverage_trans.imm5;
    // n: coverpoint coverage_trans.n;
    // z: coverpoint coverage_trans.z;
    // p: coverpoint coverage_trans.p;
    // imm: coverpoint coverage_trans.imm;
    // instruction: coverpoint coverage_trans.instruction;
    // npc_in: coverpoint coverage_trans.npc_in;
    // // pragma uvmf custom covergroup end
    cp_opcode:    coverpoint t_cov.instruction[15:12] {
                     bins add_type = {ADD};
                     bins and_type = {AND};
                     bins not_type = {NOT};
                     bins ld_type =  {LD};
                     bins ldr_type = {LDR};
                     bins ldi_type = {LDI};
                     bins lea_type = {LEA};
                     bins  st_type = {ST};
                     bins str_type = {STR};
                     bins sti_type = {STI};
                     bins  br_type = {BR};
                     bins jmp_type = {JMP};
                  }

     cp_prevopcode: coverpoint {first,prev_t_cov.instruction[15:12]} {
                       bins add_type = {0,ADD};
                       bins and_type = {0,AND};
                       bins not_type = {0,NOT};
                       bins ld_type =  {0,LD};
                       bins ldr_type = {0,LDR};
                       bins ldi_type = {0,LDI};
                       bins lea_type = {0,LEA};
                       bins  st_type = {0,ST};
                       bins str_type = {0,STR};
                       bins sti_type = {0,STI};
                       bins  br_type = {0,BR};
                       bins jmp_type = {0,JMP};
                  }

     cross_opcode_prev_opcode : cross cp_opcode, cp_prevopcode;

     cp_alu_ops: coverpoint t_cov.instruction[15:12] {
                    bins alu_add_type = {ADD};
                    bins alu_and_type = {AND};
                    bins alu_not_type = {NOT};
                }
     cp_ld_ops: coverpoint t_cov.instruction[15:12] {
                   bins mem_ld_type  =  {LD};
                   bins mem_ldr_type = {LDR};
                   bins mem_ldi_type = {LDI};
                   bins mem_lea_type = {LEA};
                }
   
     cp_str_ops: coverpoint t_cov.instruction[15:12] {
                    bins mem_st_type  = {ST};
                    bins mem_str_type = {STR};
                    bins mem_sti_type = {STI};
                 }

     cp_flow_switch_ops: coverpoint t_cov.instruction[15:12] {
                     bins flow_switch_br_type  = {BR};
                     bins flow_switch_jmp_type = {JMP};
                  }

     cp_dest: coverpoint (t_cov.instruction[11:9]) {
                 bins dest_addr[] = {[3'h0:3'h7]};
              }

     cross_alu_dest: cross cp_alu_ops, cp_dest;

     cross_ld_dest:  cross cp_ld_ops, cp_dest;

     cp_alu_sr1: coverpoint (t_cov.instruction[8:6]) iff(alu == 1'b1){
                    bins alu_sr1[] = {[3'h0:3'h7]};
                 }

     cp_str_sr: coverpoint(t_cov.instruction[11:9]) iff(str == 1'b1){
                   bins str_sr[] = {[3'h0:3'h7]};
                }

     cp_br_nzp: coverpoint (t_cov.instruction[11:9]) iff(t_cov.instruction[15:12] == BR){
                   bins br_nzp[] = {[3'h1:3'h7]};
                } 

     cp_add: coverpoint (t_cov.instruction[15:12]){
                bins add_operation = {ADD} ;
             }

     cp_and: coverpoint (t_cov.instruction[15:12]){
                bins and_operation = {AND} ;
             }

     cp_imm_bit: coverpoint (t_cov.instruction[5]) {
                    bins imm_zero_one[] = {[1'b0:1'b1]};
                 }

     cross_add_imm_bit : cross cp_add, cp_imm_bit;
     cross_and_imm_bit : cross cp_and, cp_imm_bit;

     cp_add_imm_val: coverpoint (t_cov.instruction[4:0]) iff(t_cov.instruction[15:12] == ADD && t_cov.instruction[5] == 1'b1){
                     bins add_imm_bit_zero[] = {[5'b0:5'b1]};
                     bins add_imm_bit_one_toggle      = {[5'b00010: 5'b00011]};
                     bins add_imm_bit_two_toggle      = {[5'b00100: 5'b00111]};
                     bins add_imm_bit_three_toggle    = {[5'b01000: 5'b01111]};
                     bins add_imm_bit_four_toggle     = {[5'b10000: 5'b11111]};
                     }

     cp_and_imm_val: coverpoint (t_cov.instruction[4:0]) iff(t_cov.instruction[15:12] == AND && t_cov.instruction[5] == 1'b1){
                     bins and_imm_bit_zero[] = {[5'b0:5'b1]};
                     bins and_imm_bit_one_toggle      = {[5'b00010: 5'b00011]};
                     bins and_imm_bit_two_toggle      = {[5'b00100: 5'b00111]};
                     bins and_imm_bit_three_toggle    = {[5'b01000: 5'b01111]};
                     bins and_imm_bit_four_toggle     = {[5'b10000: 5'b11111]};
                     }

     cp_add_sr2_val: coverpoint (t_cov.instruction[2:0]) iff(t_cov.instruction[15:12] == ADD && t_cov.instruction[5] == 1'b0){
                        bins add_sr2_val[] = {[3'h0:3'h7]};
                     }

     cp_and_sr2_val: coverpoint (t_cov.instruction[2:0]) iff(t_cov.instruction[15:12] == AND && t_cov.instruction[5] == 1'b0){
                        bins and_sr2_val[] = {[3'h0:3'h7]};
                     }

     cp_pcoffset9: coverpoint (t_cov.instruction[8:0]) iff(t_cov.instruction[15:12] == LD || t_cov.instruction[15:12] == LDI || t_cov.instruction[15:12] == LEA || t_cov.instruction[15:12] == ST || t_cov.instruction[15:12] == STI || t_cov.instruction[15:12] == BR)  {
                     bins offset9_bit_zero[] = {[9'b0:9'b1]};
                     bins offset9_bit_one_toggle      = {[9'b000000010: 9'b000000011]};
                     bins offset9_bit_two_toggle      = {[9'b000000100: 9'b000000111]};
                     bins offset9_bit_three_toggle    = {[9'b000001000: 9'b000001111]};
                     bins offset9_bit_four_toggle     = {[9'b000010000: 9'b000011111]};
                     bins offset9_bit_five_toggle     = {[9'b000100000: 9'b000111111]};
                     bins offset9_bit_six_toggle      = {[9'b001000000: 9'b001111111]};
                     bins offset9_bit_seven_toggle    = {[9'b010000000: 9'b011111111]};
                     bins offset9_bit_eight_toggle    = {[9'b100000000: 9'b111111111]};
                     }

     cp_pcoffset6: coverpoint (t_cov.instruction[5:0]) iff(t_cov.instruction[15:12] == LDR || t_cov.instruction[15:12] == STR)  {
                     bins offset6_bit_zero[] = {[6'b0:6'b1]};
                     bins offset6_bit_one_toggle      = {[6'b000010: 6'b000011]};
                     bins offset6_bit_two_toggle      = {[6'b000100: 6'b000111]};
                     bins offset6_bit_three_toggle    = {[6'b001000: 6'b001111]};
                     bins offset6_bit_four_toggle     = {[6'b010000: 6'b011111]};
                     bins offset6_bit_five_toggle     = {[6'b100000: 6'b111111]};
                     }

     cp_baser_val: coverpoint (t_cov.instruction[8:6]) iff(t_cov.instruction[15:12] == LDR || t_cov.instruction[15:12] == STR || t_cov.instruction[15:12] == JMP){
                      bins baser[] = {[3'h0:3'h7]};
                   }

     cp_baser_instr: coverpoint(t_cov.instruction[15:12]) {
                       bins baser_instr[] = {LDR,STR,JMP};
                    }
     cp_offset6_instr: coverpoint (t_cov.instruction[15:12]) {
                          bins offset6_instr[] = {LDR,STR};
                       }
     cp_offset9_instr: coverpoint (t_cov.instruction[15:12]) {
                          bins offset9_instr[] = {LD,LDI,LEA,ST,STI,BR};
                       }
     cross_baser_instr: cross cp_baser_instr, cp_baser_val;
     cross_offset9_instr: cross cp_offset9_instr, cp_pcoffset9;
     cross_offset6_instr: cross cp_offset6_instr, cp_pcoffset6;
  endgroup

covergroup add_and_ops_cg;
   // 2 Ops in question
   cp_imm_alu_ops : coverpoint t_cov.instruction[15:12] {
                     bins add_type = {ADD};
                     bins and_type = {AND};
   }

   // Immediate bit for Immediate Ops
   cp_imm_alu_ops_imm_bit : coverpoint t_cov.instruction[5] iff(t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND) {
                  bins imm = {1'b1};
   }
   
   // Immediate bit for Immediate Ops
   cp_reg_alu_ops_imm_bit : coverpoint t_cov.instruction[5] iff(t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND) {
                  bins register = {1'b0};
   }

   // DST for both op types
   cp_alu_ops_dr : coverpoint t_cov.instruction[11:9] iff(t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND) {
                  bins dst[] = {[3'h0:3'h7]};
   }

   // SR1 for both op types
   cp_imm_alu_ops_sr1 : coverpoint t_cov.instruction[8:6] iff(t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND) {
                  bins src[] = {[3'h0:3'h7]};
   }

   // SR2 for register op type
   cp_imm_alu_ops_sr2 : coverpoint t_cov.instruction[2:0] iff(t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND) {
                  bins src[] = {[3'h0:3'h7]};
   }

   // Padding for register op types
   cp_reg_alu_ops_padding : coverpoint t_cov.instruction[4:3] iff(t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND) {
                  bins padding = {2'b00};
   }

   // Immediate value for immediate op types
   cp_imm_alu_ops_imm_val : coverpoint t_cov.instruction[4:0] iff(t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND) {
                  bins imm_val[] = {[5'd0:5'd31]};
   }

   // Cross checking to see if imm versions of ADD/AND have been sampled - 4096 possible valid transactions (2048 each for ADD & AND)
   cross_imm_alu_ops : cross cp_imm_alu_ops, cp_alu_ops_dr, cp_imm_alu_ops_sr1, cp_imm_alu_ops_imm_bit, cp_imm_alu_ops_imm_val;

   // Cross checking to see all add reg values - 1024 possible valid transactions (512 each for ADD & AND)
   cross_reg_alu_ops : cross cp_imm_alu_ops, cp_alu_ops_dr, cp_imm_alu_ops_sr1, cp_reg_alu_ops_imm_bit, cp_reg_alu_ops_padding, cp_imm_alu_ops_sr2;

endgroup

covergroup not_cg;
   // NOT
   cp_not_op : coverpoint t_cov.instruction[15:12] {
      bins not_type = {NOT};
   }

   // DST 
   cp_not_op_dr : coverpoint t_cov.instruction[11:9] iff(t_cov.instruction[15:12] == NOT) {
                  bins dst[] = {[3'h0:3'h7]};
   } 

   // SR1
   cp_not_op_sr1 : coverpoint t_cov.instruction[8:6] iff(t_cov.instruction[15:12] == NOT) {
                  bins src[] = {[3'h0:3'h7]};
   }

   // Padding
   cp_not_op_padding : coverpoint t_cov.instruction[5:0] iff(t_cov.instruction[15:12] == NOT) {
                     bins padding = {6'd63};
   }

   // Cross checking to sample all possible NOT ops - 64 possible valid transactions
   cross_not_ops : cross cp_not_op, cp_not_op_dr, cp_not_op_sr1, cp_not_op_padding;

endgroup

covergroup loads_cg;

   // LD, LDI, LEA opcodes
   cp_ld_ldi_lea_ops : coverpoint t_cov.instruction[15:12] {
      bins ld_type = {LD};
      bins ldi_type = {LDI};
      bins lea_type = {LEA};
   }

   // LDR opcode
   cp_ldr_op : coverpoint t_cov.instruction[15:12] {
      bins ldr_type = {LDR};
   }

   // DR for all opcodes
   cp_loads_dr : coverpoint t_cov.instruction[11:9] iff(t_cov.instruction[15:12] == LD || t_cov.instruction[15:12] == LDI || t_cov.instruction[15:12] == LEA || t_cov.instruction[15:12] == LDR) {
      bins dr[] = {[3'd0:3'd7]};
   }

   // BaseR for LDR
   cp_ldr_base_r : coverpoint t_cov.instruction[8:6] iff(t_cov.instruction[15:12] == LDR) {
      bins base_r[] = {[3'd0:3'd7]};
   }

   // PC offset 9 for LD, LDI, LEA
   cp_pc_offset_9 : coverpoint t_cov.instruction[8:0] iff(t_cov.instruction[15:12] == LD || t_cov.instruction[15:12] == LDI || t_cov.instruction[15:12] == LEA) {
      bins pc_offset_9[] = {[9'd0 : 9'd511]};
   }

   // PC offset 6 for LDR
   cp_pc_offset_6 : coverpoint t_cov.instruction[5:0] iff(t_cov.instruction[15:12] == LDR) {
      bins pc_offset_6[] = {[6'd0:6'd63]};
   }

   // Cross checking to sample all possible LD, LDI, LEA ops - 12288 possible valid ops (4096 each opcode)
   cross_ld_ldi_lea_ops : cross cp_ld_ldi_lea_ops, cp_loads_dr, cp_pc_offset_9;

   // Cross checking to sample all possible LDR ops - 4096 possible valid ops
   cross_ldr_ops : cross cp_ldr_op, cp_loads_dr, cp_ldr_base_r, cp_pc_offset_6;

endgroup

covergroup stores_cg;

   // ST & STI opcodes
   cp_st_sti_ops : coverpoint t_cov.instruction[15:12] {
      bins st_type = {ST};
      bins sti_type = {STI};
   }

   // STR opcode
   cp_str_op : coverpoint t_cov.instruction[15:12] {
      bins str_type = {STR};
   }

   // SR for all opcodes
   cp_stores_sr : coverpoint t_cov.instruction[11:9] iff(t_cov.instruction[15:12] == ST || t_cov.instruction[15:12] == STI || t_cov.instruction[15:12] == STR) {
      bins sr[] = {[3'd0:3'd7]};
   }

   // BaseR for STR
   cp_str_base_r : coverpoint t_cov.instruction[8:6] iff(t_cov.instruction[15:12] == STR) {
      bins base_r[] = {[3'd0:3'd7]};
   }

   // PC offset 9 for ST, STI
   cp_st_sti_offset_9 : coverpoint t_cov.instruction[8:0] iff(t_cov.instruction[15:12] == ST || t_cov.instruction[15:12] == STI) {
      bins pc_offset_9[] = {[9'd0:9'd511]};
   }

   // PC offset 6 for STR
   cp_str_offset_6 : coverpoint t_cov.instruction[5:0] iff(t_cov.instruction[15:12] == STR) {
      bins pc_offset_6[] = {[6'd0:6'd63]};
   }

   // Cross checking to sample all possible ST, STI ops - 8192 possible valid ops (4096 each opcode)
   cross_st_sti_ops : cross cp_st_sti_ops, cp_stores_sr, cp_st_sti_offset_9;

   // Cross checking to sample all possible STR ops - 4096 possible valid ops
   cross_str_ops : cross cp_str_op, cp_stores_sr, cp_str_base_r, cp_str_offset_6;

endgroup

covergroup control_cg;

   // BR opcode
   cp_br_op : coverpoint t_cov.instruction[15:12] {
      bins br_type = {BR};
   }

   // JMP opcode
   cp_jmp_op : coverpoint t_cov.instruction[15:12] {
      bins br_type = {JMP};
   }

   // NZP for BR
   cp_nzp : coverpoint t_cov.instruction[11:9] iff(t_cov.instruction[15:12] == BR) {
      bins BRZ   = {3'b010};
      bins BRNP  = {3'b101};
      bins BRP   = {3'b001};
      bins BRZP  = {3'b011};
      bins BRN   = {3'b100};
      bins BRNZ  = {3'b110};
      bins BRNZP = {3'b111};
   }

   // 3-bit padding for JMP
   cp_jmp_padding_3 : coverpoint t_cov.instruction[11:9] iff(t_cov.instruction[15:12] == JMP) {
      bins padding = {3'b000};
   }

   // Pc offset 9 for BR
   cp_br_pc_offset_9 : coverpoint t_cov.instruction[8:0] iff(t_cov.instruction[15:12] == BR) {
      bins pc_offset_9[] = {[9'd0:9'd511]};
   }

   // Base R for JMP
   cp_jmp_base_r : coverpoint t_cov.instruction[8:6] iff(t_cov.instruction[15:12] == JMP) {
      bins base_r[] = {[3'd0:3'd7]};
   }

   // 6-bit padding for JMP
   cp_jmp_padding_6 : coverpoint t_cov.instruction[5:0] iff(t_cov.instruction[15:12] == JMP) {
      bins padding = {6'b000000};
   }

   // Cross checking to sample all possible BR ops - 3584 possible valid ops
   cross_br_ops : cross cp_br_op, cp_nzp, cp_br_pc_offset_9;

   // Cross checking to sample all possible JMP ops - 8 possible valid ops
   cross_jmp_ops : cross cp_jmp_op, cp_jmp_padding_3, cp_jmp_base_r, cp_jmp_padding_6;

endgroup

  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new(string name="", uvm_component parent=null);
    super.new(name,parent);
    imem_transaction_cg=new;
    add_and_ops_cg=new;
    not_cg=new;
    loads_cg=new;
    stores_cg=new;
    control_cg=new;
//    `uvm_warning("COVERAGE_MODEL_REVIEW", "A covergroup has been constructed which may need review because of either generation or re-generation with merging.  Please note that transaction variables added as a result of re-generation and merging are not automatically added to the covergroup.  Remove this warning after the covergroup has been reviewed.")
  endfunction

  // ****************************************************************************
  // FUNCTION : build_phase()
  // This function is the standard UVM build_phase.
  //
  function void build_phase(uvm_phase phase);
    imem_transaction_cg.set_inst_name($sformatf("imem_transaction_cg_%s",get_full_name()));
    add_and_ops_cg.set_inst_name($sformatf("add_and_ops_cg%s",get_full_name()));
    not_cg.set_inst_name($sformatf("not_cg%s",get_full_name()));
    loads_cg.set_inst_name($sformatf("loads_cg%s",get_full_name()));
    stores_cg.set_inst_name($sformatf("stores_cg%s",get_full_name()));
    control_cg.set_inst_name($sformatf("control_cg%s",get_full_name()));
  endfunction

  // ****************************************************************************
  // FUNCTION: write (T t)
  // This function is automatically executed when a transaction arrives on the
  // analysis_export.  It copies values from the variables in the transaction 
  // to local variables used to collect functional coverage.  
  //
  virtual function void write (T t);
    `uvm_info("IMEM_COV","Received transaction",UVM_HIGH);
    coverage_trans = t;
     t_cov = t;
     if(t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND || t_cov.instruction[15:12] == NOT )  alu = 1;
     if(t_cov.instruction[15:12] == LD  || t_cov.instruction[15:12] == LDR || t_cov.instruction[15:12] == LDI || t_cov.instruction[15:12] == LEA) ld = 1;
     if(t_cov.instruction[15:12] == ST  || t_cov.instruction[15:12] == STR || t_cov.instruction[15:12] == STI )  str = 1;
     if(t_cov.instruction[15:12] == BR  || t_cov.instruction[15:12] == JMP )  flow_switch = 1;
     if(first == 1'b1) prev_t_cov = t;

    imem_transaction_cg.sample();
    add_and_ops_cg.sample();
    not_cg.sample();
    loads_cg.sample();
    stores_cg.sample();
    control_cg.sample();

    prev_t_cov = t;
    first = 1'b0;
    alu = 0;
    ld = 0;
    str = 0;
    flow_switch = 0;

    //imem_transaction_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

