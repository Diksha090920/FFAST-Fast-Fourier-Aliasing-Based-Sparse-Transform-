`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 15:58:43
// Design Name: 
// Module Name: tb_fft_4point
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


module tb_fft_4point;

    // Inputs (16-bit signed fixed-point values)

    reg clk;

    reg rst;
    
    reg input_valid;

    reg signed [15:0] x0_real, x0_imag;

    reg signed [15:0] x1_real, x1_imag;

    reg signed [15:0] x2_real, x2_imag;
    
    reg signed [15:0] x3_real, x3_imag;

    

    // inputs

    wire signed [15:0] X0_real, X0_imag;

    wire signed [15:0] X1_real, X1_imag;

    wire signed [15:0] X2_real, X2_imag;

    wire signed [15:0] X3_real, X3_imag; 

    // Instantiate FFT module

    fft_4point uut (

        .clk(clk),

        .rst(rst),
        
        .input_valid(input_valid),

        .x0_real(x0_real), .x0_imag(x0_imag),

        .x1_real(x1_real), .x1_imag(x1_imag),

        .x2_real(x2_real), .x2_imag(x2_imag),
        
        .x3_real(x3_real), .x3_imag(x3_imag),

        .X0_real(X0_real), .X0_imag(X0_imag),

        .X1_real(X1_real), .X1_imag(X1_imag),

        .X2_real(X2_real), .X2_imag(X2_imag),
        
        .X3_real(X3_real), .X3_imag(X3_imag)

    );



    // Clock Generation (100 MHz -> 10 ns period)

    always #5 clk = ~clk;



    initial begin

        // Initialize signals

        clk = 0;

        rst = 1;
        
        input_valid = 0; 

        x0_real = 16'bx; x0_imag = 16'bx;

        x1_real = 16'bx; x1_imag = 16'bx;

        x2_real = 16'bx; x2_imag = 16'bx;

        x3_real = 16'bx; x3_imag = 16'bx;

        // Apply Reset (Hold for 20ns)

        #10;

        rst = 0;



        // Apply test inputs on next clock cycle

        #10;

        x0_real = 16'sd0;      x0_imag = 16'sd0;

        x1_real = 16'sd5878;   x1_imag = 16'sd0;

        x2_real = 16'sd9511;   x2_imag = 16'sd0;
        
        x3_real = 16'sd9511;   x3_imag = 16'sd0;
        
         input_valid = 1; // ? Trigger input valid
        #10 input_valid = 0;


 

        x0_real = 16'sd9511;      x0_imag = 16'sd0;

        x1_real = 16'sd0;        x1_imag = 16'sd0;

        x2_real = -16'sd9511;   x2_imag = 16'sd0;
        
        x3_real = 16'sd5878;    x3_imag = 16'sd0;

        input_valid = 1; // ? Trigger again
       #10 input_valid = 0;

        // Wait for results (Allow pipeline delay if needed)

        #100;



        // Display results

        $display("X(0) = %d + %di", X0_real, X0_imag);

        $display("X(1) = %d + %di", X1_real, X1_imag);

        $display("X(2) = %d + %di", X2_real, X2_imag);
        
        $display("X(3) = %d + %di", X3_real, X3_imag);



        // Finish simulation

        #20;

        $stop;

    end

endmodule

