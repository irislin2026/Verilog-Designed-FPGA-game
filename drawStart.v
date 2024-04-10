module drawStart(	
	input clk, reset,
	input DrawStartScreenState,
	output reg [2:0] VGA_Colour,// VGA pixel colour (RGB)
	output reg [7:0] VGA_x, 
	output reg [6:0] VGA_y,
	output reg doneDrawStart
	);

	reg [7:0] counter_x = 0;  // horizontal counter
	reg [6:0] counter_y = 0;  // vertical counter
	
	
	always @(posedge clk)  // horizontal counter
	begin 
		if (counter_x < 8'd159)
			counter_x <= counter_x + 1;  // horizontal counter total of 159 horizontal pixels
		else
			counter_x <= 0;              
	end  // always 
	
	always @ (posedge clk)  // vertical counter
	begin 
		if (counter_x == 8'd159)  // only counts up 1 count after horizontal finishes 159 counts
			begin
				if (counter_y < 7'd119)  // vertical counter total of 119 pixels
					counter_y <= counter_y + 1;
				else
					counter_y <= 0;              
			end  // if (counter_x...
	end  // always
	// end counter
	
	always @ (posedge clk)
	begin
		if (!reset)begin
			VGA_x <= 8'b0;
			VGA_y <= 7'b0;
			VGA_Colour <= 3'b001;//blue
			doneDrawStart <= 1'b0;
		end
		if(DrawStartScreenState)begin
			if (counter_x < 8'd159)begin
				if (counter_y < 7'd119)begin
					VGA_Colour <= 3'b001;	
					VGA_x <= counter_x;
					VGA_y <= counter_y;
					doneDrawStart <= 1'b0;
				end
			end
			else if(counter_x == 8'd 159)begin
				if (counter_y == 7'd119)begin
					VGA_Colour <= 3'b001;	
					VGA_x <= counter_x;
					VGA_y <= counter_y;
					doneDrawStart <= 1'b1;
				end	
			end	
		end
	end
endmodule
		