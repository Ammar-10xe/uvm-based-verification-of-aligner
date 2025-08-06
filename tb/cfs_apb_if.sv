///////////////////////////////////////////////////////////////////////////////
// File:        cfs_apb_if.sv
// Author:      Ammar Khan
// Description: APB interface.
///////////////////////////////////////////////////////////////////////////////

`ifndef CFS_APB_IF_SV
  `define CFS_APB_IF_SV

  interface cfs_apb_if(input reg pclk);

    logic preset_n,pwrite,penable,psel,pready,pslverr;
    logic[`CFS_APB_MAX_ADDR_WIDTH-1:0] paddr;
    logic[`CFS_APB_MAX_DATA_WIDTH-1:0] pwdata;
    logic[`CFS_APB_MAX_DATA_WIDTH-1:0] prdata;

  endinterface

`endif
