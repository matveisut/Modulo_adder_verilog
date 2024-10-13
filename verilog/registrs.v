module Reg16Bit (
    input wire [7:0] input_a,
    input wire [7:0] input_b,
    input wire clk,
    output reg [7:0] out_a,
    output reg [7:0] out_b
);

reg first_clk = 1'b1;
reg second_clk = 1'b0;


initial begin
    out_b <= 8'b00000000;
end

always @(posedge clk) begin
    
    if (first_clk) begin
      first_clk <= 1'b0; // Устанавливаем флаг после первого тактового сигнала
      second_clk <= 1'b1;
      out_b <= 8'b00000000; // Устанавливаем значение по умолчанию
      out_a <= input_a[7:0];
    end else if (second_clk) begin    
      first_clk <= 1'b0; // Устанавливаем флаг после первого тактового сигнала
      second_clk <= 1'b0;
      out_b <= 8'b00000000; // Устанавливаем значение по умолчанию
      out_a <= input_a[7:0];
    end else begin
        out_a <= input_a[7:0]; // Подключение первых 8 бит к out_a
        out_b <= input_b[7:0]; // Подключение последних 8 бит к out_b
    end
  end

endmodule

module Reg9Bit (
    input wire [8:0] data_in,
    input wire clk,
    output reg [7:0] data_out_8bit, // 8 битный выход
    output reg data_out_1bit // 1 битный выход
);

// Присваивание значения на выходе регистра
always @(posedge clk) begin
    data_out_8bit <= data_in[7:0]; // Присваивание младших 8 бит на 8-битный выход
    data_out_1bit <= data_in[8]; // Присваивание старшего бита на 1-битный выход
end

endmodule
