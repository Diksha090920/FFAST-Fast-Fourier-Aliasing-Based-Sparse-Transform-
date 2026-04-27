`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2025 11:29:06
// Design Name: 
// Module Name: tb_sampling
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


module tb_sampling;

  // Clock and reset
  reg clk;
  reg reset;
  reg valid_in;
  //wire valid_out;

  // Instantiate your DUT (Device Under Test)
  sampling uut (
    .clk(clk),
    .reset(reset),
    .valid_in(valid_in)
   // .valid_out(valid_out)
    // Add FFT input ports here if you want to monitor them
  );

  // Clock generation
  always #5 clk = ~clk; // 100 MHz clock

  initial begin
    // Initialize
    clk = 0;
    reset = 1;
    valid_in = 0;

    // Apply reset
    #20;
    reset = 0;

    // Wait a bit then trigger input
    #10;
    valid_in = 1;
    #10;
    valid_in = 0;

    // Wait for inputs (adjust this depending on latency of FFT)
    #2000;

    // You can add input checks here, or manually inspect waveforms
    $display("Simulation completed.");
  
  end

endmodule
