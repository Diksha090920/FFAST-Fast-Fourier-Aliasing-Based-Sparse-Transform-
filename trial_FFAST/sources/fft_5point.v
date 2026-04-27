`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2025 11:18:43
// Design Name: 
// Module Name: fft_5point
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


module fft_5point (

    input clk, rst,

    

    input wire input_valid,

    

    input wire signed [15:0] x0_real, x0_imag,

    input wire signed [15:0] x1_real, x1_imag,

    input wire signed [15:0] x2_real, x2_imag,

    input wire signed [15:0] x3_real, x3_imag,

    input wire signed [15:0] x4_real, x4_imag,
    
    

    output reg signed [15:0] X0_real, X0_imag,

    output reg signed [15:0] X1_real, X1_imag,

    output reg signed [15:0] X2_real, X2_imag,

    output reg signed [15:0] X3_real, X3_imag,

    output reg signed [15:0] X4_real, X4_imag


);



    // Twiddle factors in Q1.15 format

    parameter signed [15:0] C50 = 16'sd10125;

    parameter signed [15:0] C51 = -16'sd26509;

    parameter signed [15:0] C52 = -16'sd31165;

    parameter signed [15:0] C53 = -16'sd19267;



    // Pipeline registers

    reg signed [16:0] sum1_real, sum2_real, diff1_real, diff2_real;

    reg signed [16:0] sum1_imag, sum2_imag, diff1_imag, diff2_imag;

    reg signed [31:0] mult1_real, mult2_real, mult3_real, mult4_real;

    reg signed [31:0] mult1_imag, mult2_imag, mult3_imag, mult4_imag;

    

     wire signed [15:0] inter_x0_real, inter_x0_imag;

    wire signed [15:0] inter_x1_real, inter_x1_imag;

    wire signed [15:0] inter_x2_real, inter_x2_imag;

    wire signed [15:0] inter_x3_real, inter_x3_imag;

    wire signed [15:0] inter_x4_real, inter_x4_imag;

    wire signed [15:0] inter1_X0_real, inter1_X0_imag;
    wire signed [15:0] inter2_X0_real, inter2_X0_imag;
    wire signed [15:0] inter3_X0_real, inter3_X0_imag;

    reg signed [15:0] X0_internal_real , X0_internal_imag;

    

      // D Flip-Flop Instantiations for Delay

    //D_flip_flop d2 (clk, rst, x0_real, inter_x0_real);

    D_flip_flop d1 (.clk(clk), .rst(rst), .d(x0_real), .q(inter_x0_real));

    D_flip_flop d2 (.clk(clk), .rst(rst), .d(x0_imag), .q(inter_x0_imag));

    D_flip_flop d3 (.clk(clk), .rst(rst), .d(x1_real), .q(inter_x1_real));  

    D_flip_flop d4 (.clk(clk), .rst(rst), .d(x1_imag), .q(inter_x1_imag));

    D_flip_flop d5 (.clk(clk), .rst(rst), .d(x2_real), .q(inter_x2_real));

    D_flip_flop d6 (.clk(clk), .rst(rst), .d(x2_imag), .q(inter_x2_imag));

    D_flip_flop d7 (.clk(clk), .rst(rst), .d(x3_real), .q(inter_x3_real));

    D_flip_flop d8 (.clk(clk), .rst(rst), .d(x3_imag), .q(inter_x3_imag));

    D_flip_flop d9(.clk(clk), .rst(rst), .d(x4_real),  .q(inter_x4_real));

    D_flip_flop d10 (.clk(clk), .rst(rst),.d(x4_imag), .q(inter_x4_imag));

    

    



    always @(posedge clk or posedge rst) begin

        if (rst) begin

            sum1_real <= 0; sum2_real <= 0;

            diff1_real <= 0; diff2_real <= 0;

            sum1_imag <= 0; sum2_imag <= 0;

            diff1_imag <= 0; diff2_imag <= 0;

        end else begin

            sum1_real <= inter_x1_real + inter_x4_real;

            sum2_real <= inter_x2_real + inter_x3_real;

            diff1_real <= inter_x1_real - inter_x4_real;

            diff2_real <= inter_x2_real - inter_x3_real;

            

            sum1_imag <= inter_x1_imag + inter_x4_imag;

            sum2_imag <= inter_x2_imag + inter_x3_imag;

            diff1_imag <= inter_x1_imag - inter_x4_imag;

            diff2_imag <= inter_x2_imag - inter_x3_imag;

        end

    end



    always @(posedge clk or posedge rst) begin

        if (rst) begin

            mult1_real <= 0; mult2_real <= 0;

            mult3_real <= 0; mult4_real <= 0;

            mult1_imag <= 0; mult2_imag <= 0;

            mult3_imag <= 0; mult4_imag <= 0;

        end else begin

            mult1_real <= (sum1_real * C50) >> 15;

            mult2_real <= (sum2_real * C51) >> 15;

            mult3_real <= (sum1_real * C51) >> 15;

            mult4_real <= (sum2_real * C50) >> 15;

            

            mult1_imag <= (diff1_real * C52) >> 15;

            mult2_imag <= (diff2_real * C53) >> 15;

            mult3_imag <= (diff1_real * C53) >> 15;

            mult4_imag <= (diff2_real * -C52) >> 15;

        end

    end



    always @(posedge clk or posedge rst) begin

        if (rst) begin

            X0_real <= 0; X0_imag <= 0;

            X1_real <= 0; X1_imag <= 0;

            X2_real <= 0; X2_imag <= 0;

            X3_real <= 0; X3_imag <= 0;

            X4_real <= 0; X4_imag <= 0;

            

        end else begin

            X0_internal_real <= (inter_x0_real + inter_x1_real + inter_x2_real + inter_x3_real + inter_x4_real)>>2;

            X0_internal_imag <= (inter_x0_imag + inter_x1_imag + inter_x2_imag + inter_x3_imag + inter_x4_imag)>>2;

            X1_real <= (mult1_real[15:0] + mult2_real[15:0])>>2;

            X1_imag <= (mult1_imag[15:0] + mult2_imag[15:0])>>2;

            X2_real <= (mult3_real[15:0] + mult4_real[15:0])>>2;

            X2_imag <= (mult3_imag[15:0] + mult4_imag[15:0])>>2;

            X3_real <= (mult3_real[15:0] + mult4_real[15:0])>>2;

            X3_imag <= (-mult3_imag[15:0] - mult4_imag[15:0])>>2;

            X4_real <= (mult1_real[15:0] + mult2_real[15:0])>>2;

            X4_imag <= (-mult1_imag[15:0] - mult2_imag[15:0])>>2;

        end

    end
    
     D_flip_flop d11 (.clk(clk), .rst(rst), .d(X0_internal_real), .q(inter1_X0_real));
    // D_flip_flop d12 (.clk(clk), .rst(rst), .d(inter1_X0_real), .q(inter2_X0_real));
     //D_flip_flop d13 (.clk(clk), .rst(rst), .d(inter2_X0_real), .q(inter3_X0_real));
     
     D_flip_flop d14 (.clk(clk), .rst(rst), .d(X0_internal_imag), .q(inter1_X0_imag));
    // D_flip_flop d15 (.clk(clk), .rst(rst), .d(inter1_X0_imag), .q(inter2_X0_imag));
     //D_flip_flop d16 (.clk(clk), .rst(rst), .d(inter2_X0_imag), .q(inter3_X0_imag));
     
     always @ (posedge clk or posedge rst) begin
     if (rst) begin
      X0_real <=0;
      X0_imag <=0;
      end else begin
      X0_real <= inter1_X0_real;
      X0_imag <= inter1_X0_imag;
      end
     end 
     
     
endmodule
