`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.03.2025 16:04:31
// Design Name: 
// Module Name: multi16
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


module multi16(

  input  wire [16:0] in_17bit,  // 17-bit input  data
  input  wire [7:0]  in_8bit,   // 8-bit  input  data
  input wire [16:0] out        // 17-bit input data
  
  );

  wire        flag;             // determine the sign of the product
  wire [16:0] in_17bit_b;       // store 17-bit true form data
  wire [7:0]  in_8bit_b;        // store 8-bit  true form data
  wire [24:0] mul;
  wire [16:0] mul_b;
  reg  [24:0] neg_mul;

//**************************** The following are assign statements ****************************

  assign  in_17bit_b = (in_17bit[16] == 1) ? ~in_17bit[16:0] + 1'b1 : in_17bit;  // If in_17bit is a negative number, transform to 2's complement, otherwise remain the same.

  always @ ( in_17bit or in_8bit ) begin
    case ( in_8bit )
      8'b00000000: neg_mul = 25'b0;
      8'b00110001: neg_mul = ( in_17bit_b << 0 ) + ( in_17bit_b << 4 ) + ( in_17bit_b << 5 );
      8'b11001111: neg_mul = ( in_17bit_b << 0 ) + ( in_17bit_b << 4 ) + ( in_17bit_b << 5 );  
      8'b01011010: neg_mul = ( in_17bit_b << 1 ) + ( in_17bit_b << 3 ) + ( in_17bit_b << 4 ) + ( in_17bit_b << 6 ); 
      8'b10100110: neg_mul = ( in_17bit_b << 1 ) + ( in_17bit_b << 3 ) + ( in_17bit_b << 4 ) + ( in_17bit_b << 6 );  
      8'b01110110: neg_mul = ( in_17bit_b << 1 ) + ( in_17bit_b << 2 ) + ( in_17bit_b << 4 ) + ( in_17bit_b << 5 ) + ( in_17bit_b << 6 ); 
      8'b10001010: neg_mul = ( in_17bit_b << 1 ) + ( in_17bit_b << 2 ) + ( in_17bit_b << 4 ) + ( in_17bit_b << 5 ) + ( in_17bit_b << 6 ); 
      8'b01111111: neg_mul = ( in_17bit_b << 7 );
      8'b10000001: neg_mul = ( in_17bit_b << 7 );
    endcase
  end

//  assign  in_8bit_b  = ( in_8bit[7]  == 1) ?  ~in_8bit[7:0]  + 1'b1 : in_8bit;   // If in_8bit is a negative number, transform to 2's complement, otherwise remain the same.
  assign  flag  = in_17bit[16] + in_8bit[7];                  // Determine the sign of the product. 
//  assign  mul   = in_17bit_b[16:0] * in_8bit_b[7:0];          // Calculate the absolute value of the product.
  assign  mul = neg_mul;
  assign  mul_b = {mul[23:15], mul[14:7]};                    // Shift, combining integer and fractional parts.
  assign  out   = (flag == 1) ? ~mul_b[16:0] + 1'b1 : mul_b;  // input only keep 17 bits.
  
endmodule