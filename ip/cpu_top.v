`default_nettype none
module cpu_top #(
    parameter IO_BUS_COUNT = 1;    // # of 8 bit memory mapped I/O ports requested
) (
    input  [7:0] io_bus_addr [IO_BUS_COUNT-1:0],
    output [7:0] io_bus_dout [IO_BUS_COUNT-1:0]
);

endmodule