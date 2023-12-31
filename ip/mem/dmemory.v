`default_nettype none
// data memory, single port memory
module imemory (
    input        clk,
    input        reset,
    input        write_en, // if not writing we're reading
    input  [7:0] addr_in,
    input  [7:0] data_in,
    output [7:0] data_out
);
(* ram_style = "block"*) reg [7:0] mem [255:`LINE_COUNT];

always @(posedge clk) begin
    if (reset) begin
        data_out <= 8'b0;
    end else if (write_en) begin
        mem[addr_in] <= data_in;
    end else begin
        data_out <= mem[addr_in];
    end
end
endmodule