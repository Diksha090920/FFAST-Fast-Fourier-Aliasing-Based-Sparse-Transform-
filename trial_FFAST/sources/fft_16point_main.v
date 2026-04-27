`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2025 15:47:42
// Design Name: 
// Module Name: fft_16point_main
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
`include "ctrl_16.v"
`include "s_p_16.v"
`include "mux_16.v"
`include "butterfly_16.v"
`include "reg1_16.v"
`include "p_s_16.v"


module fft_16point_main(
 input  wire        clk,       // clock
  input  wire        rst,     // reset
  input  wire [33:0] data_in,   // input from pin
  input wire [33:0] data_out   // input to pin

  );

  wire        mux_flag, demux_flag, s_p_flag;  // seems need a signal called ps_s_flag. Refer warning 02.
  wire[2:0]   rotation;
  wire[135:0] data_1, data_2, data_3, data_4;

  ctrl_16 ctrl0(
    .clk(clk),                // input from top
    .rst(rst),            // input from top
    .s_p_flag_in(s_p_flag),   // input from s_p
    .mux_flag(mux_flag),      // input to mux
    .rotation(rotation),      // input to butterfly
    .demux_flag(demux_flag)   // input to p_s and reg1
  );

  s_p_16 s_p0(
    .clk(clk),                // input from top
    .rst(rst),            // input from top
    .data_in_1(data_in),      // input from top
    .data_out_1(data_1),      // input to mux
    .s_p_flag_out(s_p_flag)   // input to ctrl
  );

  mux_16 mux0(
    .mux_flag(mux_flag),      // input from ctrl 
    .clk(clk),
    .rst(rst),
    .data_in_2(data_1),       // input from s_p
    .data_in_1(data_2),       // input from reg1
    .data_in_3(data_4),
    .data_out(data_3)         // input to butterfly
  );

  butterfly_16 butterfly0(
    .calc_in(data_3),         // input from mux
    .rotation(rotation),      // input from ctrl
    .calc_out(data_4)         // input to demux
  );

  reg1_16 reg10(
    .clk(clk),                // input from top
    .rst(rst),            // input from top
    .data_in_2(data_4),
    .data_out_2(data_2),
    .reg_datain_flag(demux_flag)
  );

  p_s_16 p_s0(
    .clk(clk),                // input from top
    .rst(rst),            // input from top
    .p_s_flag_in(demux_flag), // input from ctrl  #* Warning 02: Please check no p_s_flag in ctrl *#
    .data_in_3(data_4),       // input from demux
    .data_out_3(data_out)     // input to top
  );
   
endmodule
