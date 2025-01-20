Developed a UVM-based Testbench for verifying the LC3 Microcontroller. 
Each pipeline stage(Fetch, Decode, Execute, Memory and Writeback) is verified using its own Environment containg Sequencer, Driver, Monitor, Predictor and Scoreboard.
Steps to run project:
1. Point UVMF_HOME path in Makefile(line 22) and in regress.sh(line 3)
2. Go to sim path: group16_p3/uvmf_template_output/project_benches/lc3/sim
3. do ./regress.sh OR source regress.sh
4. After all simulation is done, automatically coverage window will open.
