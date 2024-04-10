module keyboard(
	input clk, 
	input reset,
	input EraseState,
	// Bidirectionals
	inout			PS2_CLK,
	inout		 	PS2_DAT,
	
	output [7:0] ps2_key_data,
	output reg up_pressed, down_pressed, left_pressed, right_pressed, enter_pressed, space_pressed
	);
	
	wire key_pressed;
	
	PS2_Controller PS2(.CLOCK_50(clk), .reset(~reset),.PS2_CLK(PS2_CLK), .PS2_DAT(PS2_DAT), 
					.received_data(ps2_key_data), .received_data_en(key_pressed));
	
	always@(posedge clk)
	begin
		if (reset==1'b0 && EraseState)begin
			up_pressed <= 1'b0;
			down_pressed <= 1'b0;
			right_pressed <= 1'b0;
			left_pressed <= 1'b0;
			space_pressed <= 1'b0;
			enter_pressed <= 1'b0;
		end
		if(key_pressed)begin
			case(ps2_key_data)
				8'h1d: begin
					up_pressed <= 1'b1;
					down_pressed <= 1'b0;
					right_pressed <= 1'b0;
					left_pressed <= 1'b0;
					space_pressed <= 1'b0;
					enter_pressed <= 1'b0;
				end
				
				8'h1b: begin
					up_pressed <= 1'b0;
					down_pressed <= 1'b1;
					right_pressed <= 1'b0;
					left_pressed <= 1'b0;
					space_pressed <= 1'b0;
					enter_pressed <= 1'b0;
				end
				
				8'h1c: begin
					up_pressed <= 1'b0;
					down_pressed <= 1'b0;
					right_pressed <= 1'b0;
					left_pressed <= 1'b1;
					space_pressed <= 1'b0;
					enter_pressed <= 1'b0;
				end
				8'h23: begin
					up_pressed <= 1'b0;
					down_pressed <= 1'b0;
					right_pressed <= 1'b1;
					left_pressed <= 1'b0;
					space_pressed <= 1'b0;
					enter_pressed <= 1'b0;
				end
				8'h29:begin
					up_pressed <= 1'b0;
					down_pressed <= 1'b0;
					right_pressed <= 1'b0;
					left_pressed <= 1'b0;
					space_pressed <= 1'b1;
					enter_pressed <= 1'b0;
				end
				8'h5a: begin
					up_pressed <= 1'b0;
					down_pressed <= 1'b0;
					right_pressed <= 1'b0;
					left_pressed <= 1'b0;
					space_pressed <= 1'b0;
					enter_pressed <= 1'b1;
				end
				default: begin
					up_pressed <= 1'b0;
					down_pressed <= 1'b0;
					right_pressed <= 1'b0;
					left_pressed <= 1'b0;
					space_pressed <= 1'b0;
					enter_pressed <= 1'b0;
				end
			endcase
		end	
	end				
endmodule
		