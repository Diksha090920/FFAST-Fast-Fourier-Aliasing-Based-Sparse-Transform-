`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.04.2025 11:42:44
// Design Name: 
// Module Name: tb_delay_n_cycles
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




module tb_delay_n_cycles;

  parameter N = 16; // Bit-width
  parameter D = 4;  // Delay in clock cycles

  // Inputs
  reg clk;
  reg rst;
  reg [N-1:0] d;

  // input
  wire [N-1:0] q;

  // Instantiate the delay module
  delay_n_cycles #(
    .N(N),
    .D(D)
  ) uut (
    .clk(clk),
    .rst(rst),
    .d(d),
    .q(q)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
  end

  // Test stimulus
  initial begin
    $display("Time\tclk\trst\td\tq");
    $monitor("%0dns\t%b\t%b\t%0d\t%0d", $time, clk, rst, d, q);

    // Initialize
    rst = 1;
    d   = 0;
    #15;         // Keep reset for 15ns
    rst = 0;

    // Apply input data
    #10 d = 5;
    #10 d = 10;
    #10 d = 15;
    #10 d = 20;
    #10 d = 25;
    #10 d = 30;
    #10 d = 0;

    // Wait and finish
    #100;
    $finish;
  end

endmodule
