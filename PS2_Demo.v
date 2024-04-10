 /*****************************************************************************
 * #################
 * ACKNOWLEDGEMENTS
 * #################
 *
 * Credit for PS/2 demo module:
 * https://github.com/Navash914/Verilog-HDL/blob/master/PS2_Demo.v
 *
  *****************************************************************************/

module PS2_Demo (
	// Inputs
	CLOCK_50,
	KEY,
	LEDR,
	HEX1, HEX0,

	// Bidirectionals
	PS2_CLK,
	PS2_DAT,
	

);
	input CLOCK_50;
	input [3:0] KEY;
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1;
	inout PS2_CLK;
	inout PS2_DAT;
	
	wire reset;
	assign reset = KEY[0];
	
	wire [7:0] data;
	
	keyboard k1(
	.clk(CLOCK_50), 
	.reset(reset),
	.PS2_CLK(PS2_CLK),
	.PS2_DAT(PS2_DAT),
	.ps2_key_data(data),
	.up_pressed(LEDR[0]), 
	.down_pressed(LEDR[1]), 
	.left_pressed(LEDR[2]), 
	.right_pressed(LEDR[3]), 
	.enter_pressed(LEDR[4]), 
	.space_pressed(LEDR[5])
	);
	
	Hexadecimal_To_Seven_Segment h0 (data[7:4], HEX1);
	Hexadecimal_To_Seven_Segment h1 (data[3:0], HEX0);
	
	
		

endmodule

/******************************************************************************
 *                                                                            *
 * Module:       Hexadecimal_To_Seven_Segment                                 *
 * Description:                                                               *
 *      This module converts hexadecimal numbers for seven segment displays.  *
 *                                                                            *
 ******************************************************************************/

module Hexadecimal_To_Seven_Segment (
	// Inputs
	hex_number,

	// Bidirectional

	// Outputs
	seven_seg_display
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
// Inputs
input		[3:0]	hex_number;

// Bidirectional

// Outputs
output		[6:0]	seven_seg_display;

/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/
// Internal Wires

// Internal Registers

// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/


/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/

assign seven_seg_display =
		({7{(hex_number == 4'h0)}} & 7'b1000000) |
		({7{(hex_number == 4'h1)}} & 7'b1111001) |
		({7{(hex_number == 4'h2)}} & 7'b0100100) |
		({7{(hex_number == 4'h3)}} & 7'b0110000) |
		({7{(hex_number == 4'h4)}} & 7'b0011001) |
		({7{(hex_number == 4'h5)}} & 7'b0010010) |
		({7{(hex_number == 4'h6)}} & 7'b0000010) |
		({7{(hex_number == 4'h7)}} & 7'b1111000) |
		({7{(hex_number == 4'h8)}} & 7'b0000000) |
		({7{(hex_number == 4'h9)}} & 7'b0010000) |
		({7{(hex_number == 4'hA)}} & 7'b0001000) |
		({7{(hex_number == 4'hB)}} & 7'b0000011) |
		({7{(hex_number == 4'hC)}} & 7'b1000110) |
		({7{(hex_number == 4'hD)}} & 7'b0100001) |
		({7{(hex_number == 4'hE)}} & 7'b0000110) |
		({7{(hex_number == 4'hF)}} & 7'b0001110); 

/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/


endmodule
