module Multiplexer2to1 (
    input wire [7:0] input_from_sum,
    input wire [7:0] input_from_reg9,
    input wire control,
    output wire [7:0] out
);

assign out = (control) ? input_from_sum : input_from_reg9;

endmodule
