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
  reg clk,reset_n;

  initial begin // 100MHZ clk generation
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin // reset generation
    reset_n = 1;
    repeat(5) @(posedge clk);
    reset_n = 0;
    repeat(5) @(posedge clk);
    reset_n = 1;
  end

  //Instantiate the DUT
  cfs_aligner dut(
    .clk(    clk),
    .reset_n(reset_n)
  );

  // Start UVM test and phases
  initial begin
    run_test("");
    $dumpfile("dump.vcd");
    $dumpvars;
  end

endmodule
