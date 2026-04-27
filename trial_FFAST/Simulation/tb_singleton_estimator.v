`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2025 15:26:55
// Design Name: 
// Module Name: tb_singleton_estimator
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


`timescale 1ns / 1ps

module tb_singleton_estimator;

    // Inputs
    reg clk;
    reg rst;
    reg signed [15:0] x1_real;
    reg signed [15:0] x1_imag;
    reg signed [15:0] x2_real;
    reg signed [15:0] x2_imag;

    // input
    wire ratio_test_pass;

    // Instantiate the Unit Under Test (UUT)
    singleton_estimator uut (
        .clk(clk),
        .rst(rst),
        .x1_real(x1_real),
        .x1_imag(x1_imag),
        .x2_real(x2_real),
        .x2_imag(x2_imag),
        .ratio_test_pass(ratio_test_pass)
    );

    always #5 clk =~clk;
    
    
    initial begin
    
        clk=0;
        rst =1;
        
//        x1_real=16'bx ; x1_imag=16'bx;
//        x2_real =16'bx; x2_imag= 16'bx;
        #10;
        rst =0;
        
//        #10;
//        $display("Starting testbench...\n");
        
        
        // Test Case 1: Equal magnitudes
        x1_real = 16'sd41;   x1_imag = -16'sd19;     // magnitude = 5
        x2_real = -16'sd107;   x2_imag = -16'sd158;     // magnitude = 5
        #10;
        $display("TC1 | Expected: 1, Got: %b", ratio_test_pass);
        
//         x1_real = 16'sd75;   x1_imag = -16'sd102;     // magnitude = 5
//        x2_real = -16'sd119;   x2_imag = -16'sd36;     // magnitude = 5
//        #10;
//        $display("TC1 | Expected: 1, Got: %b", ratio_test_pass);
        
//        x1_real = 16'sd102;   x1_imag = -16'sd79;     // magnitude = 5
//        x2_real = 16'sd3;   x2_imag = -16'sd17;     // magnitude = 5
//        #10;
//        $display("TC1 | Expected: 1, Got: %b", ratio_test_pass);
        
//         x1_real = 16'sd23;   x1_imag = -16'sd45;     // magnitude = 5
//        x2_real = 16'sd237;   x2_imag = 16'sd60;     // magnitude = 5
//        #10;
//        $display("TC1 | Expected: 1, Got: %b", ratio_test_pass);
        
//        x1_real = 16'sd109;   x1_imag = 16'sd171;     // magnitude = 5
//        x2_real = 16'sd161;   x2_imag = 16'sd33;     // magnitude = 5
//        #10;
//        $display("TC1 | Expected: 1, Got: %b", ratio_test_pass);
        
//         x1_real = 16'sd41;   x1_imag = 16'sd145;     // magnitude = 5
//        x2_real = 16'sd183;   x2_imag = 16'sd90;     // magnitude = 5
//        #10;
//        $display("TC1 | Expected: 1, Got: %b", ratio_test_pass);
        
//         x1_real = -16'sd1;   x1_imag = -16'sd1;     // magnitude = 5
//        x2_real = -16'sd1;   x2_imag = -16'sd1;     // magnitude = 5
//        #10;
//        $display("TC1 | Expected: 1, Got: %b", ratio_test_pass);
        
//         x1_real = 16'sd157;   x1_imag = -16'sd42;     // magnitude = 5
//        x2_real = -16'sd192;   x2_imag = -16'sd95;     // magnitude = 5
//        #10;
//        $display("TC1 | Expected: 1, Got: %b", ratio_test_pass);
                
//        x1_real = -16'sd128;   x1_imag = -16'sd370;     // magnitude = 5
//        x2_real = -16'sd423;   x2_imag = -16'sd107;     // magnitude = 5
//        #10;
//        $display("TC1 | Expected: 1, Got: %b", ratio_test_pass);
                
//        // Test Case 2: Unequal magnitudes
//        x1_real = 16'sd6;   x1_imag = 16'sd8;     // magnitude = 10
//        x2_real = 16'sd5;   x2_imag = 16'sd5;     // magnitude ? 10
//        #10;
//        $display("TC2 | Expected: 0, Got: %b", ratio_test_pass);

//        // Test Case 3: Equal magnitudes, negative values
//        x1_real = -16'sd7;  x1_imag = -16'sd24;   // magnitude = 25
//        x2_real = 16'sd15;  x2_imag = 16'sd20;    // magnitude = 25
//        #10;
//        $display("TC3 | Expected: 1, Got: %b", ratio_test_pass);

//        // Test Case 4: Both zero
//        x1_real = 16'sd0;   x1_imag = 16'sd0;
//        x2_real = 16'sd0;   x2_imag = 16'sd0;
//        #10;
//        $display("TC4 | Expected: 0, Got: %b", ratio_test_pass);

//        $display("\nTestbench completed.");

#100
        $stop;
    end

endmodule
