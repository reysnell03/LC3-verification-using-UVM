#!/bin/bash
#POINT PROPER UVMF_HOME PATH HERE
export UVMF_HOME=/mnt/ncsudrive/a/asingh64/aditya/fall24/748/project_directory/project_3/FINAL_SUBMISSION/UVMF_2023.4/

export QUESTA_HOME=/mnt/apps/public/COE/mg_apps/questa2023.4/questasim
ml questa
make clean
rm -rf transcripts
mkdir transcripts
python3 $UVMF_HOME/scripts/uvmf_bcr.py questa test:test_top verbosity:UVM_LOW "use_vis_uvm:True" "enable_trlog:False" "seed:129456"
cp run.log transcripts/top_transcript
python3 $UVMF_HOME/scripts/uvmf_bcr.py questa test:dummy_test verbosity:UVM_LOW "use_vis_uvm:True" "enable_trlog:False" "seed:193456"
cp run.log transcripts/alu_transcript
python3 $UVMF_HOME/scripts/uvmf_bcr.py questa test:control_test verbosity:UVM_LOW "use_vis_uvm:True" "enable_trlog:False" "seed:923456"
cp run.log transcripts/contrl_transcript
python3 $UVMF_HOME/scripts/uvmf_bcr.py questa test:mem_test verbosity:UVM_LOW "use_vis_uvm:True" "enable_trlog:False" "seed:123459"
cp run.log transcripts/mem_transcript
python3 $UVMF_HOME/scripts/uvmf_bcr.py questa test:misc_test verbosity:UVM_LOW "use_vis_uvm:True" "enable_trlog:False" "seed:123496"
cp run.log transcripts/misc_transcript
python3 $UVMF_HOME/scripts/uvmf_bcr.py questa test:mem_coverage verbosity:UVM_LOW "use_vis_uvm:True" "enable_trlog:False" "seed:123956"
cp run.log transcripts/mem_coverage_transcript

python3 $UVMF_HOME/scripts/uvmf_bcr.py questa test:ld_st_coverage verbosity:UVM_LOW ucdb_filename:ld_st_coverage_1.ucdb "use_vis_uvm:True" "enable_trlog:False" "seed:123956"
cp run.log transcripts/ld_st_coverage_transcript_1
python3 $UVMF_HOME/scripts/uvmf_bcr.py questa test:ldr_str_coverage verbosity:UVM_LOW ucdb_filename:ldr_str_coverage_1.ucdb "use_vis_uvm:True" "enable_trlog:False" "seed:129456"
cp run.log transcripts/ldr_str_coverage_transcript_1

python3 $UVMF_HOME/scripts/uvmf_bcr.py questa test:control_test_2 verbosity:UVM_LOW "use_vis_uvm:True" "enable_trlog:False" "seed:69890"
cp run.log transcripts/contrl_transcript_2
python3 $UVMF_HOME/scripts/uvmf_bcr.py questa test:mem_test_2 verbosity:UVM_LOW "use_vis_uvm:True" "enable_trlog:False" "seed:67899"
cp run.log transcripts/mem_transcript_2
python3 $UVMF_HOME/scripts/uvmf_bcr.py questa test:alu_test_2 verbosity:UVM_LOW "use_vis_uvm:True" "enable_trlog:False" "seed:756438"
cp run.log transcripts/alu_transcript_2
python3 $UVMF_HOME/scripts/uvmf_bcr.py questa test:mem_cov_test_2 verbosity:UVM_LOW "use_vis_uvm:True" "enable_trlog:False" "seed:826484"
cp run.log transcripts/mem_cov_transcript_2

xml2ucdb -format Excel ./lc3_testplan.xml ./lc3_testplan.ucdb
vcover merge -stats=none -strip 0 -totals sim_and_testplan_merged.ucdb ./*.ucdb
visualizer -viewcov ./sim_and_testplan_merged.ucdb