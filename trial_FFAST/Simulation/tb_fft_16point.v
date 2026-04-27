`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.04.2025 11:11:07
// Design Name: 
// Module Name: tb_fft_16point
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

module tb_fft_16point();

  reg         clk;
  reg         rst;
  reg  [33:0] InputData [0:47];
  reg  [5:0]  i;
  reg  [33:0] data_in;
  wire [33:0] data_out;

  fft_16point_main fft0(.clk(clk), 
          .rst(rst), 
          .data_in(data_in), 
          .data_out(data_out)
          );

  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1'b1;
    $display("\nLoad Data\n");  
    $readmemb("Data_input.txt", InputData); // Need to modify.

    #8 begin
      rst = 1'b0;
      for (i = 0; i < 47; i = i + 1) begin
        data_in = InputData[i];
        #8
        $display("[%d] %b_%b_%b %b_%b_%b\n", (i+13)%16, data_out[33], data_out[32:25], data_out[24:17], data_out[16], data_out[15:8], data_out[7:0]);
      end 
    end
  end


//always #5 clk =~clk;

//initial begin
//clk =0;
//rst =1;

//InputData [0]= 34'hx;
//InputData [1]= 34'hx;
//InputData [2]= 34'hx;
//InputData [3]= 34'hx;
//InputData [4]= 34'hx;
//InputData [5]= 34'hx;
//InputData [6]= 34'hx;
//InputData [7]= 34'hx;
//InputData [8]= 34'hx;
//InputData [9]= 34'hx;
//InputData [10]= 34'hx;
//InputData [11]= 34'hx;
//InputData [12]= 34'hx;
//InputData [13]= 34'hx;
//InputData [14]= 34'hx;
//InputData [15]= 34'hx;

//#10
//rst =0;

//#10;

//InputData [0]= 34'b0000000000000000000000000000000000000;
//InputData [1]= 34'b0000001011011110110000000000000000000;
//InputData [2]= 34'b0000010010100010111000000000000000000;
//InputData [3]= 34'b0000010010100010111000000000000000000;
//InputData [4]= 34'b0000001011011110110000000000000000000;
//InputData [5]= 34'b0000000000000000000000000000000000000;
//InputData [6]= 34'b1111110100100001010000000000000000000;
//InputData [7]= 34'b1111101101011101001000000000000000000;
//InputData [8]= 34'b1111101101011101001000000000000000000;
//InputData [9]= 34'b1111110100100001010000000000000000000;
//InputData [10]= 34'b0000000000000000000000000000000000000;
//InputData [11]= 34'b0000001011011110110000000000000000000;
//InputData [12]= 34'b0000010010100010111000000000000000000;
//InputData [13]= 34'b0000010010100010111000000000000000000;
//InputData [14]= 34'b0000001011011110110000000000000000000;
//InputData [15]= 34'b0000000000000000000000000000000000000;


//#10;
//InputData [0]= 34'b0000000000000000000000000000000000000;
//InputData [1]= 34'b0010001011011110110000000000000000000;
//InputData [2]= 34'b0000010010100010111000000000110000000;
//InputData [3]= 34'b0000010010100010111000000000000000000;
//InputData [4]= 34'b0000101011011110110000000001000000100;
//InputData [5]= 34'b0000000000000000000000000000000000000;
//InputData [6]= 34'b1111110100100001010000000000000000000;
//InputData [7]= 34'b1111101101011101001000000000000000000;
//InputData [8]= 34'b1111101101011101001000000000000000000;
//InputData [9]= 34'b1111110100100001010000000000000000000;
//InputData [10]= 34'b0000000000000000000000000000000000000;
//InputData [11]= 34'b0000000011011110110000000011000000000;
//InputData [12]= 34'b0000010010100010111000000000000000000;
//InputData [13]= 34'b0000010010100010111000000000000000000;
//InputData [14]= 34'b0000001011011110110000000000000000000;
//InputData [15]= 34'b0001000000000000000000000000000100010;

//#100;
//$stop;

//end
endmodule