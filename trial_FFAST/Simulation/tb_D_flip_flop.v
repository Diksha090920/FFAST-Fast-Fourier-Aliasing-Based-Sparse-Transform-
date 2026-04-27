`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2025 17:48:08
// Design Name: 
// Module Name: tb_D_flip_flop
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


module tb_D_flip_flop;

 reg clk;

 reg rst;

 

 reg [15:0] d;

 wire [15:0] q;



 D_flip_flop duut (

     clk,      // Clock input

      rst,      // Asynchronous reset

     d,        // Data input

   q         // input

);

 

 always #5 clk = ~clk;

 

 initial begin

 clk=0;

 rst =1;

 

 #10

 rst =0;

 #10

 d= 16'd15;

 

 

 #10

 

 d=16'd26;

 

 #10

 d=16'd45;

 

end 

   

endmodule

