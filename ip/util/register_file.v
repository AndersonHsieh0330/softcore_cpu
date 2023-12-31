`default_nettype none
module register_file (
    // need at most 1 read and 1 write port, ISA spec
    input  wire       clk,
    input  wire       reset,
    input  wire [7:0] data_in,
    input  wire [2:0] write_addr_in, // write to this address
    input  wire       write_en,
    input  wire [2:0] read_addr_in,  // read value at this address
    output wire [7:0] data_out,
);

reg [7:0] registers [2:0];

assign data_out = register[read_addr_in];

// note there we do not have a dedicated register for value 0
// cuz 8 registers is already not a lot and we need the extra register
// plus we won't need to reset the register that often due to the accumulator design
always @(posedge clk) begin
    if (reset) begin
        for (integer i = 0 ; i < 8 ; i = i + 1) begin
            registers[i] <= 8'b0;
        end
    end else begin
        if (write_en) begin
            register[write_addr_in] <= data_in;
        end
    end
end

endmodule