`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.02.2025 11:35:09
// Design Name: 
// Module Name: tb_fft_3point
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



//module tb_fft_3point;
//    // Inputs (16-bit signed fixed-point values)
//    reg clk;
//    reg rst_n;
//    reg signed [15:0] x0_real, x0_imag;
//    reg signed [15:0] x1_real, x1_imag;
//    reg signed [15:0] x2_real, x2_imag;
    
//    // inputs
//    wire signed [15:0] X0_real, X0_imag;
//    wire signed [15:0] X1_real, X1_imag;
//    wire signed [15:0] X2_real, X2_imag;

//    // Instantiate FFT module
//    fft_3point uut (
//        .clk(clk),
//        .rst_n(rst_n),
//        .x0_real(x0_real), .x0_imag(x0_imag),
//        .x1_real(x1_real), .x1_imag(x1_imag),
//        .x2_real(x2_real), .x2_imag(x2_imag),
//        .X0_real(X0_real), .X0_imag(X0_imag),
//        .X1_real(X1_real), .X1_imag(X1_imag),
//        .X2_real(X2_real), .X2_imag(X2_imag)
//    );

//    // Clock Generation (100 MHz -> 10 ns period)
//    always #5 clk = ~clk;

//    initial begin
//        // Initialize signals
//        clk = 0;
//        rst_n = 0;
//        x0_real = 0; x0_imag = 0;
//        x1_real = 0; x1_imag = 0;
//        x2_real = 0; x2_imag = 0;

//        // Apply Reset (Hold for 20ns)
//        #20;
//        rst_n = 1;

//        // Apply test inputs on next clock cycle
//        #10;
//        x0_real = 16'sd0;      x0_imag = 16'sd0;
//        x1_real = 16'sd5878;   x1_imag = 16'sd0;
//        x2_real = 16'sd9511;   x2_imag = 16'sd0;

//        // Wait for results (Allow pipeline delay if needed)
//        #50;

//        // Display results
//        $display("X(0) = %d + %di", X0_real, X0_imag);
//        $display("X(1) = %d + %di", X1_real, X1_imag);
//        $display("X(2) = %d + %di", X2_real, X2_imag);

//        // Finish simulation
//        #20;
//        $stop;
//    end
//endmodule

module tb_fft_3point;

    // Inputs (16-bit signed fixed-point values)

    reg clk;

    reg rst;
    
    reg input_valid;

    reg signed [15:0] x0_real, x0_imag;

    reg signed [15:0] x1_real, x1_imag;

    reg signed [15:0] x2_real, x2_imag;

    

    // inputs

    wire signed [15:0] X0_real, X0_imag;

    wire signed [15:0] X1_real, X1_imag;

    wire signed [15:0] X2_real, X2_imag;



    // Instantiate FFT module

    fft_3point uut (

        .clk(clk),

        .rst(rst),
        
        .input_valid(input_valid),

        .x0_real(x0_real), .x0_imag(x0_imag),

        .x1_real(x1_real), .x1_imag(x1_imag),

        .x2_real(x2_real), .x2_imag(x2_imag),

        .X0_real(X0_real), .X0_imag(X0_imag),

        .X1_real(X1_real), .X1_imag(X1_imag),

        .X2_real(X2_real), .X2_imag(X2_imag)

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



        // Apply Reset (Hold for 20ns)

        #10;

        rst = 0;



        // Apply test inputs on next clock cycle

        #10;

        x0_real = 16'sd5878;      x0_imag = 16'sd0;

        x1_real = 16'sd5878;   x1_imag = 16'sd0;

        x2_real = -16'sd9511;   x2_imag = 16'sd0;
        
         input_valid = 1; // ? Trigger input valid
        #10 input_valid = 0;


 

        x0_real = 16'sd9511;      x0_imag = 16'sd0;

        x1_real = 16'sd0;        x1_imag = 16'sd0;

        x2_real = -16'sd9511;   x2_imag = 16'sd0;

        input_valid = 1; // ? Trigger again
        #10 input_valid = 0;

        // Wait for results (Allow pipeline delay if needed)

        #100;



        // Display results

        $display("X(0) = %d + %di", X0_real, X0_imag);

        $display("X(1) = %d + %di", X1_real, X1_imag);

        $display("X(2) = %d + %di", X2_real, X2_imag);



        // Finish simulation

        #20;

        $stop;

    end

endmodule

