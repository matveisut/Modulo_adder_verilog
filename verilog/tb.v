`timescale 1ns/1ns  // Устанавливаем временную шкалу
`include "ModSumTb.v"

module tb;

  reg clk;                     // Создаем сигнал тактового сигнала
  reg [7:0] input_a;           // Создаем регистр для входа input_a
  reg [7:0] P_reverse;         // реверсивный код модуля P
  wire [7:0] mux_out;          // Создаем провод для выхода mux_out

  // Создаем экземпляр модуля modulo_adder
  modulo_adder modulo_adder(
    .input_a(input_a),
    .P_reverse(P_reverse),
    .clk(clk),
    .mux_out(mux_out)
  );

  always #5 clk = ~clk;       // Меняем тактовый сигнал каждые 10 временных единиц
  
  //P1 =                hex DC    bin 11011100                                                                        220
  //P2 =                hex C8    bin 11001000                                                                        200
  //P1reverse =         hex 23    bin 00100011  
  //P2reverse =         hex 37    bin 00110111

  always @(posedge clk) begin            // чередование входа P между P1 и P2
    if (P_reverse == 8'h37) begin   // P2
        P_reverse <= 8'h23;         //P1
    end else if (P_reverse == 8'h23) begin
        P_reverse <= 8'h37;
    end
  end

  // Начало теста
  initial begin

    P_reverse = 8'h23;    //начальный P = P1
    $dumpfile("tb.vcd"); 
    $dumpvars(0, tb);
    clk = 0;    // Инициализируем тактовый сигнал

    #5;
    input_a = 8'hDB;    // по 1 модулю    
    #10;               
    input_a = 8'hAA;    // по 2 модулю
    #10;                // и так далее до конца модуля
    input_a = 8'hDA;    // по 1 модулю    
    #10;               
    input_a = 8'hC7;    // по 2 модулю
    #10;       
    input_a = 8'h7A;    // по 1 модулю    
    #10;               
    input_a = 8'hA1;    // по 2 модулю
    #10;       
    input_a = 8'h8B;    // по 1 модулю    
    #10;               
    input_a = 8'hB2;    // по 2 модулю
    #10;     
    input_a = 8'h0B;    // по 1 модулю    
    #10;               
    input_a = 8'hC3;    // по 2 модулю
    #10;       
    input_a = 8'hAD;    // по 1 модулю    
    #10; 
    input_a = 8'hAE;    // по 2 модулю    
    #10;                 
    $finish;
  end
endmodule
