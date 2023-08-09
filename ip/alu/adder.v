/*
* use behavior module because I want vivado compiler to use dsp block
* instead of LUTs
*/
(* use_dsp = "yes" *) module adder
#(
	BIT_COUNT = 8
)
(
	input [BIT_COUNT-1:0] a,
	input [BIT_COUNT-1:0] b,
	output [BIT_COUNT-1:0] sum,
	output cout
);

wire [BIT_COUNT:0] result;

assign result = a + b;
assign {cout, sum} = result;

endmodule


//--- this is just a gate level full adder for fun
module full_adder_1_bit 
(
	input a,
	input b,
	input cin,
	output sum,
	output cout
);

wire a_xor_b = a ^ b;
wire a_and_b = a & b;

assign sum = a_xor_b ^ cin;
assign cout = a_and_b | (cin & a_xor_b);

endmodule
