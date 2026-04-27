`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2025 11:17:57
// Design Name: 
// Module Name: fft_3point
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
// hello Diksha



//module fft_3point (

//    input signed [15:0] x0_real, x0_imag,
//    input signed [15:0] x1_real, x1_imag,
//    input signed [15:0] x2_real, x2_imag,
    
//    input signed [15:0] X0_real, X0_imag,
//    input signed [15:0] X1_real, X1_imag,
//    input signed [15:0] X2_real, X2_imag

//);



//    // Constants (Fixed-Point Representation of cos and sin values)

//    parameter signed [15:0] C30_real = -16'sd16384;  // -0.5 * 32768 (Q1.15 format)
//    parameter signed [15:0] C31_imag = -16'sd28378;  // -0.866 * 32768 (Q1.15 format)



//    // Intermediate computations

//    wire signed [16:0] sum_real, sum_imag;  // Extra bit for addition overflow handling
//    wire signed [16:0] diff_real, diff_imag;
    
//    wire signed [31:0] C30_mult_real, C30_mult_imag;
//    wire signed [31:0] C31_mult_real, C31_mult_imag;
    
//    wire signed [31:0] temp1_real, temp1_imag;
//    wire signed [31:0] temp2_real, temp2_imag;



//    assign sum_real = x1_real + x2_real;
//    assign sum_imag = x1_imag + x2_imag;
//    assign diff_real = x1_real - x2_real;
//    assign diff_imag = x1_imag - x2_imag;



//    // Multiply with constants (Fixed-Point Multiplication with Scaling)

//    assign C30_mult_real = (C30_real * sum_real) >> 15;  // Scale back after multiplication
//    assign C30_mult_imag = (C30_real * sum_imag) >> 15;
//    assign C31_mult_real = (C31_imag * diff_real) >> 15;
//    assign C31_mult_imag = (C31_imag * diff_imag) >> 15;



//    // FFT Computation

//    assign temp1_real = x0_real + C30_mult_real +  C31_mult_imag;  //X[1]_real
//    assign temp1_imag = x0_imag + C30_mult_imag +  C31_mult_real;  // X[1]_imag
//    assign temp2_real = x0_real + C30_mult_real - C31_mult_imag; //X[2]_real
//    assign temp2_imag = x0_imag + C30_mult_imag - C31_mult_real; //X[2]_imag



//    // Truncate to 16-bit input (Saturation can be added if needed)

//    assign X0_real = x0_real + x1_real + x2_real;
//    assign X0_imag = x0_imag + x1_imag + x2_imag;

//    assign X1_real = temp1_real[15:0];  // Extract lower 16-bits
//    assign X1_imag = temp1_imag[15:0];
    
//    assign X2_real = temp2_real[15:0];
//    assign X2_imag = temp2_imag[15:0];

//endmodule

module fft_3point (
    input clk, rst,
    
    input wire input_valid,
    input wire signed [15:0] x0_real, x0_imag,
    input wire signed [15:0] x1_real, x1_imag,
    input wire signed [15:0] x2_real, x2_imag,
    
    output reg signed [15:0] X0_real, X0_imag,
    //output reg signed [15:0] inter_X0_real, inter_X0_imag,
   output reg signed [15:0] X1_real, X1_imag,
    output reg signed [15:0] X2_real, X2_imag
   
    
   // input reg data_valid
);
  //reg signed [15:0] X0_real, X0_imag;
   // wire signed [15:0] X0_real, X0_imag;
    // Constants (Fixed-Point Representation of cos and sin values)
    parameter signed [15:0] C30_real = -16'sd16384;  // -0.5 * 32768 (Q1.15 format)
    parameter signed [15:0] C31_imag = -16'sd28378;  // -0.866 * 32768 (Q1.15 format)

    // Pipeline Registers
    reg signed [16:0] sum_real, sum_imag;
    reg signed [16:0] diff_real, diff_imag;
    reg signed [31:0] C30_mult_real, C30_mult_imag;
    reg signed [31:0] C31_mult_real, C31_mult_imag;
   // reg signed [31:0] temp0_real, temp0_imag;
    reg signed [31:0] temp1_real, temp1_imag;
    reg signed [31:0] temp2_real, temp2_imag;

    // Introduce Delayed Inputs
    wire signed [15:0] inter_x0_real, inter_x0_imag;
    wire signed [15:0] inter_x1_real, inter_x1_imag;
    wire signed [15:0] inter_x2_real, inter_x2_imag;
    
    wire signed [15:0] inter1_X0_real, inter1_X0_imag;
    wire signed [15:0] inter2_X0_real, inter2_X0_imag;
    wire signed [15:0] inter3_X0_real, inter3_X0_imag;
    wire signed [15:0] inter4_X0_real, inter4_X0_imag;
    
    reg signed [15:0] X0_internal_real, X0_internal_imag;
    

    
   // reg [2:0] pipeline_counter;  // For tracking 5 cycles

   
    // D Flip-Flop Instantiations for Delay
    D_flip_flop d2 (clk, rst, x0_real, inter_x0_real);
    D_flip_flop d12 (clk, rst, inter_x0_real, inter3_X0_real);
    D_flip_flop d13 (clk, rst, inter_x0_imag, inter3_X0_imag);
    D_flip_flop d14 (clk, rst, inter3_X0_real, inter4_X0_real);
    D_flip_flop d15 (clk, rst, inter3_X0_imag, inter4_X0_imag);
    D_flip_flop d1 (.clk(clk), .rst(rst), .d(x0_imag), .q(inter_x0_imag));
    D_flip_flop d3 (.clk(clk), .rst(rst), .d(x1_real), .q(inter_x1_real));  // ? Fixed
    D_flip_flop d4 (.clk(clk), .rst(rst), .d(x1_imag), .q(inter_x1_imag));
    D_flip_flop d5 (.clk(clk), .rst(rst), .d(x2_real), .q(inter_x2_real));
    D_flip_flop d6 (.clk(clk), .rst(rst), .d(x2_imag), .q(inter_x2_imag));

    // Update all calculations to use delayed values
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sum_real <= 0;
            sum_imag <= 0;
            diff_real <= 0;
            diff_imag <= 0;
        end else begin
            sum_real <= inter_x1_real + inter_x2_real;
            sum_imag <= inter_x1_imag + inter_x2_imag;
            diff_real <= inter_x1_real - inter_x2_real;
            diff_imag <= inter_x1_imag - inter_x2_imag;
        end
    end

//D_flip_flop d12 (.clk(clk), .rst(rst), .d(sum_real), .q(inter_sum_real));
//D_flip_flop d13 (.clk(clk), .rst(rst), .d(sum_imag), .q(inter_sum_imag));
//D_flip_flop d14 (.clk(clk), .rst(rst), .d(diff_real), .q(inter_diff_real));
//D_flip_flop d15 (.clk(clk), .rst(rst), .d(diff_imag), .q(inter_diff_imag));

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            C30_mult_real <= 0;
            C30_mult_imag <= 0;
            C31_mult_real <= 0;
            C31_mult_imag <= 0;
        end else begin
            C30_mult_real <= (C30_real * sum_real) >>> 15;
            C30_mult_imag <= (C30_real * sum_imag) >>> 15;
            C31_mult_real <= (C31_imag * diff_real) >>> 15;
            C31_mult_imag <= (C31_imag * diff_imag) >>> 15;
        end
    end
    
//D_flip_flop d16 (.clk(clk), .rst(rst), .d(C30_mult_real), .q(inter_C30mul_real));
//D_flip_flop d17 (.clk(clk), .rst(rst), .d(C30_mult_imag), .q(inter_C30mul_imag));
//D_flip_flop d18 (.clk(clk), .rst(rst), .d(C31_mult_real), .q(inter_C31mul_real));
//D_flip_flop d19 (.clk(clk), .rst(rst), .d(C31_mult_imag), .q(inter_C31mul_imag));

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            temp1_real <= 0;
            temp1_imag <= 0;
            temp2_real <= 0;
            temp2_imag <= 0;
        end else begin
//            temp0_real <= inter_x0_real + inter_x1_real + inter_x2_real;
//            temp0_imag <= inter_x0_imag + inter_x1_imag + inter_x2_imag;
            temp1_real <= inter4_X0_real + C30_mult_real + C31_mult_imag;
            temp1_imag <= inter4_X0_imag + C30_mult_imag + C31_mult_real;
            temp2_real <= inter4_X0_real + C30_mult_real - C31_mult_imag;
            temp2_imag <= inter4_X0_imag + C30_mult_imag - C31_mult_real;
        end
    end
   
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            X0_real <= 0;
            X0_imag <= 0;
            X1_real <= 0;
            X1_imag <= 0;
            X2_real <= 0;
            X2_imag <= 0;
           // data_valid <=0;
        end else begin
            X0_internal_real <= inter_x0_real + inter_x1_real + inter_x2_real;
            X0_internal_imag <= inter_x0_imag + inter_x1_imag + inter_x2_imag;
            X1_real <= temp2_real[15:0];
            X1_imag <= temp1_imag[15:0];
            X2_real <= temp1_real[15:0];
            X2_imag <= temp2_imag[15:0];
           
        end
    end
    
    D_flip_flop d7 (.clk(clk), .rst(rst), .d(X0_internal_real), .q(inter1_X0_real));
    D_flip_flop d8 (.clk(clk), .rst(rst), .d(inter1_X0_real), .q(inter2_X0_real));
   // D_flip_flop d9 (.clk(clk), .rst(rst), .d(inter2_X0_real), .q(inter3_X0_real));
    
    D_flip_flop d10 (.clk(clk), .rst(rst), .d(X0_internal_imag), .q(inter1_X0_imag));
    D_flip_flop d11 (.clk(clk), .rst(rst), .d(inter1_X0_imag), .q(inter2_X0_imag));
   // D_flip_flop d12 (.clk(clk), .rst(rst), .d(inter2_X0_imag), .q(inter3_X0_imag));
    
    always @(posedge clk or posedge rst) begin
    if (rst) begin
        X0_real <= 0;
        X0_imag <= 0;
    end else begin
        X0_real <= inter2_X0_real;
        X0_imag <= inter2_X0_imag;
    end
end


endmodule