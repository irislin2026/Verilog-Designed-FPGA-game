module drawGameover(	
	input clk, reset,
	input DrawGameoverState,
	output reg [2:0] VGA_Colour,// VGA pixel colour (RGB)
	output reg [7:0] VGA_x, 
	output reg [6:0] VGA_y,
	output reg doneDrawGameover
	);

	reg [7:0]bX; 
	reg [6:0]bY;
	always @ (posedge clk)
	begin
		if (reset == 1'b0)begin
			VGA_x <= 8'b0;
			VGA_y <= 7'b0;
			VGA_Colour <= 3'b000;//black
			doneDrawGameover <= 1'b0;
			bX <= 8'b0;
			bY <=7'b0;
		end
		else if(DrawGameoverState && !doneDrawGameover)begin
					 if (bX == 8'd159 && bY == 7'd119) begin
						  bX <= 0;
						  bY <= 0;
						  doneDrawGameover <= 1'b1;
					 end 
					 else if (bX == 8'd159) begin
						  bX <= 0;
						  bY <= bY + 1;
						  doneDrawGameover <= 1'b0;
					 end 
					 else begin
						  bX <= bX + 1;
						  doneDrawGameover <= 1'b0;
					 end
					 
					 VGA_x <= bX;
					 VGA_y <= bY;
					 VGA_Colour <= 3'b010; 	
		end
	end
endmodule
		