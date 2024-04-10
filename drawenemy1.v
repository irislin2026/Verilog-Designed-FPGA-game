module drawenemy1(
    input clk, reset, space_pressed,
    input [7:0] enemy1_x,           // from datapath (also to VGA)
    input [6:0] enemy1_y,           // from datapath
    input [2:0] enemy1colour,       // from datapath
    input drawEnemy1,               // from fsm
    output reg [2:0] VGA_Colour,     // VGA pixel colour (RGB)
    output reg doneDrawEnemy1,
	output reg [7:0] xToDraw,
	output reg [6:0] yToDraw
);

   localparam shiftNumberInSquare = 4'b1111;
	localparam shiftNumberInColumn = 4'b0011;
	reg doneDrawRed;
	 
	 reg [3:0] squareCounter;

	always @(posedge clk) begin
		if (!reset || space_pressed) begin
			squareCounter <= 4'd0;
			doneDrawRed <= 1'b0;
            doneDrawEnemy1 <= 1'b0;
		end else if (!drawEnemy1) begin
				doneDrawEnemy1 <= 1'b0;
		end else if (drawEnemy1) begin
			if((doneDrawRed == 1'b0) && (squareCounter == shiftNumberInSquare)) begin
				xToDraw <= (enemy1_x + squareCounter[3:2]) % 160;
				yToDraw <= (enemy1_y + squareCounter[1:0]) % 120;
				squareCounter <= 4'd0;
				VGA_Colour <= enemy1colour;
				doneDrawRed <= 1'b1;
				doneDrawEnemy1 <= 1'b0;
			end else if ((doneDrawRed == 1'b0) && (squareCounter < shiftNumberInSquare)) begin
				squareCounter <= squareCounter + 1;
				xToDraw <= (enemy1_x + squareCounter[3:2]) % 160;
				yToDraw <= (enemy1_y + squareCounter[1:0]) % 120;
				VGA_Colour <= enemy1colour;
				doneDrawRed <= 1'b0;
				doneDrawEnemy1 <= 1'b0;
			end else if((doneDrawRed == 1'b1) && (squareCounter == shiftNumberInColumn)) begin
				xToDraw <= (enemy1_x + 4) % 160;
				yToDraw <= (enemy1_y + squareCounter[1:0]) % 120;
				squareCounter <= 4'd0;
				VGA_Colour <= 3'b000;
				doneDrawRed <= 1'b0;
				doneDrawEnemy1 <= 1'b1;
			end else if((doneDrawRed == 1'b1) && (squareCounter < shiftNumberInColumn)) begin
				xToDraw <= (enemy1_x + 4) % 160;
				yToDraw <= (enemy1_y + squareCounter[1:0]) % 120;
				squareCounter <= squareCounter + 1;
				VGA_Colour <= 3'b000;
				doneDrawRed <= 1'b1;
				doneDrawEnemy1 <= 1'b0;
			end
		end
	end
		
endmodule
