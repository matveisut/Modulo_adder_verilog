`include "adder.v"
`include "registrs.v"
`include "mux.v"

module modulo_adder (
  // Входы
  input [7:0] input_a,
  input clk,
  input [7:0] P_reverse,
  // Выходы
  output [7:0] mux_out
);

  // Внутренние провода и регистры
  wire [7:0] reg16_out_a; // выход регистра А
  wire [7:0] reg16_out_b; // выход регистра B
  wire [7:0] sum1_out;  // 8 битный выход первого 8 битного сумматора 
  wire sum1_carry;  // выход переноса первого 8 битного сумматора 
  wire [7:0] reg9_out_8;  //8 битный выход 9 битного регистра
  wire reg9_out_carry; // выход 9-го бита 9 битного регистра
  wire [7:0] sum2_out; // 8 битный выход второго сумматора (который совершает вычитание)
  wire sum2_out_carry; // выход переноса второго сумматора (который совершает вычитание)


  // 16 битный регистр (для двух чисел)
  Reg16Bit reg_16_bit (
      .input_a(input_a),
      .input_b(mux_out),
      .clk(clk),
      .out_a(reg16_out_a),
      .out_b(reg16_out_b)
  );
  // 8 битный сумматор
  Adder_8 adder_8(
      .a(reg16_out_a),
      .b(reg16_out_b),
      .out(sum1_out),
      .carry(sum1_carry)
  );
  // 9 битный регистр
  Reg9Bit reg9Bit(
      .data_in({sum1_carry, sum1_out}),
      .clk(clk),
      .data_out_8bit(reg9_out_8),
      .data_out_1bit(reg9_out_carry)
  );
  // 9 битный сумматор
  Adder_9 Adder_9(
      .a({reg9_out_carry, reg9_out_8}),
      .b({1'b1, P_reverse}),
      .cin({1'b1}),
      .out(sum2_out),
      .carry10(sum2_out_carry)
  );
  // 8 битный мультиплексор 
  Multiplexer2to1 Multiplexer2to1(
      .input_from_sum(sum2_out),
      .input_from_reg9(reg9_out_8),
      .control(sum2_out_carry),
      .out(mux_out)
  );

endmodule
