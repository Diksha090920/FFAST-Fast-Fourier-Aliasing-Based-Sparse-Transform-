`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.02.2025 15:27:46
// Design Name: 
// Module Name: rotator
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


module rotator
(
	input enable,
	input signed [16:0] x, y,
	input signed [15:0] initial_angle,
	input [2:0] count_val,
	output signed [16:0] xp, yp,
	output signed [15:0] updated_angle,
	output is_done
);

reg signed [31:0] atan_table [0:15];
integer i;
	    // Precomputed atan(2^-i) values in Q16.16 format
    initial begin
        atan_table[0]  = 32'sd25735;  // atan(2^0)  = 45.000°  (0.7854 rad)
        atan_table[1]  = 32'sd15192;  // atan(2^-1) = 26.565°  (0.4636 rad)
        atan_table[2]  = 32'sd8027;   // atan(2^-2) = 14.036°  (0.24498 rad)
        atan_table[3]  = 32'sd4074;   // atan(2^-3) = 7.125°   (0.12435 rad)
        atan_table[4]  = 32'sd2045;   // atan(2^-4) = 3.576°   (0.06242 rad)
        atan_table[5]  = 32'sd1023;   // atan(2^-5) = 1.790°   (0.03124 rad)
        atan_table[6]  = 32'sd512;    // atan(2^-6) = 0.895°   (0.01562 rad)
        atan_table[7]  = 32'sd256;    // atan(2^-7) = 0.448°   (0.00781 rad)
        atan_table[8]  = 32'sd128;    // atan(2^-8) = 0.224°   (0.00391 rad)
        atan_table[9]  = 32'sd64;     // atan(2^-9) = 0.112°   (0.00195 rad)
        atan_table[10] = 32'sd32;     // atan(2^-10) = 0.056°  (0.00098 rad)
        atan_table[11] = 32'sd16;     // atan(2^-11) = 0.028°  (0.00049 rad)
        atan_table[12] = 32'sd8;      // atan(2^-12) = 0.014°  (0.00024 rad)
        atan_table[13] = 32'sd4;      // atan(2^-13) = 0.007°  (0.00012 rad)
        atan_table[14] = 32'sd2;      // atan(2^-14) = 0.0035° (0.00006 rad)
        atan_table[15] = 32'sd1;      // atan(2^-15) = 0.0017° (0.00003 rad)
    end
//	reg signed [15:0] angle_table [0:7];
//	initial begin
//		$readmemh("scaled_angles.hex", angle_table);
//	end

	wire [16:0] x_shifted, y_shifted;
	reg signed [15:0] update_angle;
	reg signed [16:0] xnew, ynew;
	reg signed [15:0] new_angle;
	reg d;
	
	assign x_shifted = x >> count_val;
	assign y_shifted = y >>> count_val;

	assign updated_angle = new_angle;
	assign xp = xnew;
	assign yp = ynew;
	assign is_done = d;

	always @(*) begin
		if (enable) begin
			if (y[16]) begin
				xnew = x - y_shifted;
				ynew = x_shifted + y;
				update_angle = -atan_table[count_val];
			end
			else begin
				xnew = x + y_shifted;
				ynew = y - x_shifted;
				update_angle = atan_table[count_val];
			end
			new_angle = initial_angle + update_angle;
			d = (~|ynew) | (&count_val);
		end
	end
endmodule