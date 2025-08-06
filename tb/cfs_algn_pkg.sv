///////////////////////////////////////////////////////////////////////////////
// File:        cfs_algn_pkg.sv
// Author:      Ammar Khan
// Description: Environment package.
///////////////////////////////////////////////////////////////////////////////
`ifndef CFS_ALGN_PKG_SV
  `define CFS_ALGN_PKG_SV

  `include "uvm_macros.svh"
  package cfs_algn_pkg;
    import uvm_pkg::*;
    `include "cfs_algn_env.sv"
  endpackage

`endif
