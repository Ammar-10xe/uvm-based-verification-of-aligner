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

    virtual function void end_of_elaboration();
      //print's the topology
	  	uvm_top.print_topology();
    endfunction

    virtual function void report_phase(uvm_phase phase);
      uvm_report_server svr = uvm_report_server::get_server();
      super.report_phase(phase);
      if(svr.get_severity_count(UVM_FATAL)+svr.get_severity_count(UVM_ERROR)+svr.get_severity_count(UVM_WARNING)>0) begin
       `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
       `uvm_info(get_type_name(), "----            TEST FAIL          ----", UVM_NONE)
       `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
      end
      else begin
       `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
       `uvm_info(get_type_name(), "----           TEST PASS           ----", UVM_NONE)
       `uvm_info(get_type_name(), "---------------------------------------", UVM_NONE)
      end
    endfunction

  endclass

`endif
