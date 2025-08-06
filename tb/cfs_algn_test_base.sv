///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_test_base.sv
// Author:      Ammar Khan
// Date:        2023-06-27
// Description: Basic test class. It creates the instance of the environment.
//              This class should be the parent of all the tests used in the
//              verification of the Aligner.
///////////////////////////////////////////////////////////////////////////////

`ifndef CFS_ALGN_TEST_BASE_SV
  `define CFS_ALGN_TEST_BASE_SV

  class cfs_algn_test_base extends uvm_test;

    cfs_algn_env env;

    `uvm_component_utils(cfs_algn_test_base)

    function new(string name = "cfs_algn_test_base", uvm_component parent);
      super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = cfs_algn_env::type_id::create("env",this);
    endfunction

    function void report_phase(uvm_phase phase);
      super.report_phase(phase);  
      uvm_top.print_topology();
    endfunction
    
    
  endclass

`endif
