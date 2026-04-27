`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.04.2025 12:00:47
// Design Name: 
// Module Name: tb_peeling_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////




module tb_peeling_decoder;

  // Inputs
  reg clk;
  reg reset;
  
  // FFT9 input values (dummy values for simulation)
  reg signed [15:0] X0_real, X0_imag;
  reg signed [15:0] X1_real, X1_imag;
  reg signed [15:0] X2_real, X2_imag;
  reg signed [15:0] X3_real, X3_imag;
  reg signed [15:0] X4_real, X4_imag;
  reg signed [15:0] X5_real, X5_imag;
  reg signed [15:0] X6_real, X6_imag;
  reg signed [15:0] X7_real, X7_imag;
  reg signed [15:0] X8_real, X8_imag;

  // Shifted FFT9 values
  reg signed [15:0] X0_real_1, X0_imag_1;
  reg signed [15:0] X1_real_1, X1_imag_1;
  reg signed [15:0] X2_real_1, X2_imag_1;
  reg signed [15:0] X3_real_1, X3_imag_1;
  reg signed [15:0] X4_real_1, X4_imag_1;
  reg signed [15:0] X5_real_1, X5_imag_1;
  reg signed [15:0] X6_real_1, X6_imag_1;
  reg signed [15:0] X7_real_1, X7_imag_1;
  reg signed [15:0] X8_real_1, X8_imag_1;

  // Instantiate the Unit Under Test (UUT)
  peeling_decoder uut (
    .clk(clk),
    .reset(reset),
    .X0_real(X0_real), .X0_imag(X0_imag),
    .X1_real(X1_real), .X1_imag(X1_imag),
    .X2_real(X2_real), .X2_imag(X2_imag),
    .X3_real(X3_real), .X3_imag(X3_imag),
    .X4_real(X4_real), .X4_imag(X4_imag),
    .X5_real(X5_real), .X5_imag(X5_imag),
    .X6_real(X6_real), .X6_imag(X6_imag),
    .X7_real(X7_real), .X7_imag(X7_imag),
    .X8_real(X8_real), .X8_imag(X8_imag),
    .X0_real_1(X0_real_1), .X0_imag_1(X0_imag_1),
    .X1_real_1(X1_real_1), .X1_imag_1(X1_imag_1),
    .X2_real_1(X2_real_1), .X2_imag_1(X2_imag_1),
    .X3_real_1(X3_real_1), .X3_imag_1(X3_imag_1),
    .X4_real_1(X4_real_1), .X4_imag_1(X4_imag_1),
    .X5_real_1(X5_real_1), .X5_imag_1(X5_imag_1),
    .X6_real_1(X6_real_1), .X6_imag_1(X6_imag_1),
    .X7_real_1(X7_real_1), .X7_imag_1(X7_imag_1),
    .X8_real_1(X8_real_1), .X8_imag_1(X8_imag_1)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    // Initialize Inputs
    clk = 0;
    reset = 1;

//    X0_real = 16'sd1;  X0_imag = 16'sd2;
//    X1_real = 16'sd3;  X1_imag = 16'sd4;
//    X2_real = 16'sd5;  X2_imag = 16'sd6;
//    X3_real = 16'sd7;  X3_imag = 16'sd8;
//    X4_real = 16'sd9;  X4_imag = 16'sd10;
//    X5_real = 16'sd11; X5_imag = 16'sd12;
//    X6_real = 16'sd13; X6_imag = 16'sd14;
//    X7_real = 16'sd15; X7_imag = 16'sd16;
//    X8_real = 16'sd17; X8_imag = 16'sd18;

//    X0_real_1 = 16'sd10; X0_imag_1 = 16'sd20;
//    X1_real_1 = 16'sd30; X1_imag_1 = 16'sd40;
//    X2_real_1 = 16'sd50; X2_imag_1 = 16'sd60;
//    X3_real_1 = 16'sd70; X3_imag_1 = 16'sd80;
//    X4_real_1 = 16'sd90; X4_imag_1 = 16'sd100;
//    X5_real_1 = 16'sd110; X5_imag_1 = 16'sd120;
//    X6_real_1 = 16'sd130; X6_imag_1 = 16'sd140;
//    X7_real_1 = 16'sd150; X7_imag_1 = 16'sd160;
//    X8_real_1 = 16'sd170; X8_imag_1 = 16'sd180;

 #10
 reset=0;
    X0_real = 16'sd41;  X0_imag = -16'sd19;    
    X1_real = -16'sd75;  X1_imag = -16'sd102;
    X2_real = 16'sd102;  X2_imag = -16'sd79;
    X3_real = 16'sd23;  X3_imag = 16'sd45;
    X4_real = 16'sd109;  X4_imag = 16'sd171;
    X5_real = 16'sd41; X5_imag = -16'sd145;
    X6_real = -16'sd1; X6_imag = -16'sd1;
    X7_real = 16'sd157; X7_imag = -16'sd42;
    X8_real = -16'sd128; X8_imag = 16'sd370;

    X0_real_1 = -16'sd107; X0_imag_1 = -16'sd158;
    X1_real_1 = -16'sd119; X1_imag_1 = -16'sd36;
    X2_real_1 = 16'sd3; X2_imag_1 = -16'sd17;
    X3_real_1 = 16'sd237; X3_imag_1 = 16'sd60;
    X4_real_1 = 16'sd161; X4_imag_1 = 16'sd33;
    X5_real_1 = 16'sd183; X5_imag_1 = 16'sd90;
    X6_real_1 = -16'sd1; X6_imag_1 = -16'sd1;
    X7_real_1 = -16'sd192; X7_imag_1 = -16'sd95;
    X8_real_1 = -16'sd423; X8_imag_1 = 16'sd107;

    // Release reset
    #10 reset = 0;

    // Wait and observe
    #500 $stop;
  end

endmodule
