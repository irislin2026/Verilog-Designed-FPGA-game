module erase(	
	input clk, reset,
	input EraseState, space_pressed,
	output reg [2:0] VGA_Colour,// VGA pixel colour (RGB)
	output reg [7:0] VGA_x, 
	output reg [6:0] VGA_y,
	output reg doneErase
	);
	
	reg [7:0]bX; 
	reg [6:0]bY;
	reg [21:0] rateDividerCounter;   

	always @ (posedge clk)
	begin
		if (reset == 1'b0 || space_pressed)begin
			VGA_x <= 8'b0;
			VGA_y <= 7'b0;
			VGA_Colour <= 3'b000;//black
			doneErase <= 1'b0;
			bX <= 8'b0;
			bY <=7'b0;
		end
		else if(EraseState && !doneErase)begin
			if ((rateDividerCounter == 22'd25))begin
					 if (bX == 8'd159 && bY == 7'd119) begin
						  bX <= 0;
						  bY <= 0;
						  doneErase <= 1'b1;
						  rateDividerCounter <= 22'b0;
					 end 
					 else if (bX == 8'd159) begin
						  bX <= 0;
						  bY <= bY + 1;
						  doneErase <= 1'b0;
					 end 
					 else begin
						  bX <= bX + 1;
						  doneErase <= 1'b0;
					 end
					 
					 VGA_x <= bX;
					 VGA_y <= bY;
					 VGA_Colour <= 3'b000; 	
            end else if (rateDividerCounter != 22'd25) begin
                rateDividerCounter <= rateDividerCounter + 1;
			end
		end
	end
endmodule
		