//maybe not needed
module playerControl(
	input clk, reset_n,
	input left_pressed, right_pressed, up_pressed, down_pressed,
	input doneUpdate_player,
	output reg inputState, update_player, setleft, setright, setup, setdown
	);
	
	reg [3:0] current_state, next_state;
	
	localparam  S_INPUT = 4'd0,
				SET_RIGHT = 4'd1,
				SET_LEFT = 4'd2,
				SET_UP = 4'd3,
				SET_DOWN = 4'd4,
				UPDATE_POSITION = 4'd5,
				S_WAIT = 4'd6;
				

	always@(*)
    begin: state_table 
            case (current_state)
					S_INPUT: begin
						case (left_pressed)
							1'b0: begin
								case (right_pressed)
									1'b0: begin
										case (up_pressed)	
											1'b0: begin 
												case (down_pressed) 
													1'b0: next_state = S_INPUT;
													1'b1: next_state = SET_DOWN;
												endcase
											end
											1'b1: next_state = SET_UP;
										endcase
									end			
									1'b1: next_state = SET_RIGHT;
								endcase
							end	
							1'b1: next_state = SET_LEFT;
						endcase
					end	
					UPDATE_POSITION: next_state = (doneUpdate_player)? S_WAIT: UPDATE_POSITION;
					S_WAIT: next_state = S_INPUT;
					SET_LEFT: next_state = UPDATE_POSITION;
					SET_RIGHT: next_state = UPDATE_POSITION;
					SET_UP: next_state = UPDATE_POSITION;
					SET_DOWN: next_state = UPDATE_POSITION;
					
            default: next_state = S_INPUT;
        endcase
    end // state_table
	
	always@(*)
	begin: enable_signals
        // By default make all our signals 0
		  inputState <= 1'b0;
		  update_player <= 1'b0;
		  setleft <= 1'b0; 
		  setright <= 1'b0;
		  setup <= 1'b0;
		  setdown <= 1'b0;

        case (current_state)
				S_INPUT: inputState <= 1'b1; 
				UPDATE_POSITION: update_player <= 1'b1;
				SET_LEFT: begin
					inputState <= 1'b0;
					setleft <= 1'b1;
				end
				SET_RIGHT: begin
					inputState <= 1'b0;
					setright <= 1'b1;
				end
				SET_UP: begin
					setup <= 1'b1;
					inputState <= 1'b0;
				end
				SET_DOWN: begin
					setdown <= 1'b1;
					inputState <= 1'b0;
				end
				S_WAIT: begin
					update_player <= 1'b0;
					setleft <= 1'b0; 
					setright <= 1'b0;
					setup <= 1'b0;
					setdown <= 1'b0;
				end
		endcase
	end
	
	always@(posedge clk)
    begin: state_FFs
        if(!reset_n)
            current_state <= S_INPUT;
        else
            current_state <= next_state;
    end // state_FFS
endmodule
