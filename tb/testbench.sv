// ///////////////////////////////////////////////////////////////////////////////
// // File:        testbench.sv
// // Author:      Ammar Khan
// // Description: Testbench module. It contains the instance of the DUT and the
// //              logic to start the UVM test and UVM phases.
// ///////////////////////////////////////////////////////////////////////////////

`include "cfs_algn_test_pkg.sv"
import uvm_pkg::*;
import cfs_algn_test_pkg::*;

module testbench;
  reg clk;
  
  //Instantiate the interface
  cfs_apb_if apb_if(.pclk(clk));

  initial begin // 100MHZ clk generation
    clk = 0;
    forever #5 clk = ~clk;
  end

  //Instantiate the DUT
    cfs_aligner dut(
    .clk(    clk),
    .reset_n(apb_if.preset_n),
    .paddr(  apb_if.paddr),
    .pwrite( apb_if.pwrite),
    .psel(   apb_if.psel),
    .penable(apb_if.penable),
    .pwdata( apb_if.pwdata),
    .pready( apb_if.pready),
    .prdata( apb_if.prdata),
    .pslverr(apb_if.pslverr)
  );

  // Start UVM test and phases
  initial begin
    run_test("");
    $dumpfile("dump.vcd");
    $dumpvars;
  end

endmodule
