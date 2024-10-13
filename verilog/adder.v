module Adder_8(
  input wire [7:0]a,
  input wire [7:0]b,
  output wire [7:0]out,
  output wire carry
);
assign {carry, out} = a + b;

endmodule


module Adder_9(
  input wire [8:0] a,
  input wire [8:0] b,
  input wire cin, // Вход переноса
  output wire [7:0] out,
  output wire carry10,
  output wire carry9
);

assign {carry10, carry9 ,out} = a + b + cin;


endmodule

