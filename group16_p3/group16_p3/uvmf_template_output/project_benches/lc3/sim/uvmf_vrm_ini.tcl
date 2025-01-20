## Example VRM initialization proc content. See documentation
## for full list of available variables, behavior and legal values.
## Point to this file with the $UVMF_VRM_INI environment variable
## in order to enable its use.
proc vrmSetup {} {
  setIniVar code_coverage_enable 1
#  setIniVar use_vis 1
#  setIniVar dump_waves_on_rerun 1
#  setIniVar tplanfile "(%VRUNDIR%)/testplan.xml"
#  setIniVar tplanoptions "-format Excel"
#  setIniVar use_job_mgmt_run 1
#  setIniVar use_job_mgmt_build 1
#  setIniVar gridtype "PBSPro"
#setIniVar tplanoptions "-format Excel" 1
  setIniVar tplanfile "(%VRUNDIR%)/lc3_testplan.xml"
  setIniVar bcr_exec_cmd_linux "uvmf_bcr.py2" 1
  
  #setIniVar tplan_merge_options "-testassociated" 1
}
