module drawFSM(	
	input clk, resetn, collide, space_pressed, enter_pressed, 
	input doneDrawStart, doneDrawPlayer, doneDrawEnemy1,doneDrawEnemy2, 
		doneDrawEnemy3, doneDrawEnemy4,doneDrawEnemy5, doneDrawGameover, doneErasing, donedetect, 
	input doneUpdate_player, doneUpdate_enemy1, doneUpdate_enemy2, doneUpdate_enemy3, doneUpdate_enemy4, doneUpdate_enemy5,
	
	output reg [3:0]object_to_draw,
	// 0000 enemy1
	// 0001 enemy2
	// 0010 enemy3
	// 0011 enemy4
	// 0100 enemy5
	// 0101 player
	// 0110 start
	// 0111 gameover
	// 1000 erase
	output reg  Plot_on_VGA, EraseState, DrawPlayer, DrawEnemy1, DrawEnemy2, DrawEnemy3, DrawEnemy4, DrawEnemy5,
				DrawGameoverState, DrawStartScreenState, Update, UpdateEnemy1, UpdateEnemy2, UpdateEnemy3, UpdateEnemy4, 
				UpdateEnemy5, detectCollide);
				
	localparam DRAW_START = 8'd1,
			   ERASE_SCREEN= 8'd2,
			   DRAW_PLAYER = 8'd3,
			   S_WAIT1 = 8'd4,
			   DRAW_ENEMY1 = 8'd5,
			   S_WAIT2 = 8'd6,
			   DRAW_ENEMY2 = 8'd7,
			   S_WAIT3 = 8'd8,
			   DRAW_ENEMY3 = 8'd9,
			   S_WAIT4 = 8'd10,
			   DRAW_ENEMY4 = 8'd11,
			   S_WAIT5 = 8'd12,
			   DRAW_ENEMY5 = 8'd13,
			   S_WAIT6 = 8'd14,
			   ERASE_SCREEN2 = 8'd15,
			   DRAW_GAMEOVER = 8'd16,
			   S_WAIT7 = 8'd17,
			   UPDATE_ENEMY1 = 8'd18,
			   UPDATE_PLAYER = 8'd36,
			   S_WAIT8 = 8'd19,
			   S_WAIT9 = 8'd20,
			   S_WAIT10= 8'd21,
			   DONE_DRAW_GAMEOVER = 8'd22,
			   DONE_DRAW_START = 8'd23,
			   UPDATE_ENEMY2 = 8'd24,
			   UPDATE_ENEMY3 = 8'd25,
			   UPDATE_ENEMY4 = 8'd26,
			   UPDATE_ENEMY5 = 8'd27,
			   S_WAIT11 = 8'd28,
			   S_WAIT12 = 8'd29,
			   S_WAIT13 = 8'd30,
			   S_WAIT14 = 8'd31,
			   DETECT_COLLIDE = 8'd32,
			   S_WAIT15 = 8'd33,
			   S_WAIT16 = 8'd34,
			   CHECK_COLLISION = 8'd35;
			   
			   
			   
	reg [8:0] next_state;
	reg [8:0] current_state;
			   
	//Next state logic aka our state table
    always@(*)
    begin: state_table
            case (current_state)
				S_WAIT10: next_state = space_pressed ? ERASE_SCREEN : S_WAIT10;
				ERASE_SCREEN: next_state = doneErasing ? S_WAIT16 : ERASE_SCREEN;
				S_WAIT16: next_state = CHECK_COLLISION;
				CHECK_COLLISION: next_state = collide ? DRAW_GAMEOVER : UPDATE_PLAYER;
				UPDATE_PLAYER: next_state = doneUpdate_player ? S_WAIT1 : UPDATE_PLAYER;
				S_WAIT1: next_state = UPDATE_ENEMY1;
				UPDATE_ENEMY1: next_state = doneUpdate_enemy1 ? S_WAIT2 : UPDATE_ENEMY1;
				S_WAIT2: next_state = UPDATE_ENEMY2;
				UPDATE_ENEMY2: next_state = doneUpdate_enemy2 ? S_WAIT11 : UPDATE_ENEMY2;
				S_WAIT11: next_state = UPDATE_ENEMY3;
				UPDATE_ENEMY3: next_state = doneUpdate_enemy3 ? S_WAIT12 : UPDATE_ENEMY3;
				S_WAIT12: next_state = UPDATE_ENEMY4;
				UPDATE_ENEMY4: next_state = doneUpdate_enemy4 ? S_WAIT13 : UPDATE_ENEMY4;
				S_WAIT13: next_state = UPDATE_ENEMY5;
				UPDATE_ENEMY5: next_state = doneUpdate_enemy5 ? S_WAIT14 : UPDATE_ENEMY5;
				S_WAIT14: next_state = DRAW_PLAYER;
				DRAW_PLAYER: next_state = doneDrawPlayer ? S_WAIT3 : DRAW_PLAYER;
				S_WAIT3: next_state = DRAW_ENEMY1;
				DRAW_ENEMY1: next_state = doneDrawEnemy1 ? S_WAIT4 : DRAW_ENEMY1;
				S_WAIT4: next_state = DRAW_ENEMY2;
				DRAW_ENEMY2: next_state = doneDrawEnemy2 ? S_WAIT5 : DRAW_ENEMY2;
				S_WAIT5: next_state = DRAW_ENEMY3;
				DRAW_ENEMY3: next_state = doneDrawEnemy3 ? S_WAIT6 : DRAW_ENEMY3;
				S_WAIT6: next_state = DRAW_ENEMY4;
				DRAW_ENEMY4: next_state = doneDrawEnemy4 ? S_WAIT7 : DRAW_ENEMY4;
				S_WAIT7: next_state = DRAW_ENEMY5;
				DRAW_ENEMY5: next_state = doneDrawEnemy5 ? S_WAIT8 : DRAW_ENEMY5;
				S_WAIT8: next_state = CHECK_COLLISION;
			    DRAW_GAMEOVER: next_state = doneDrawGameover ?  DONE_DRAW_GAMEOVER : DRAW_GAMEOVER;
				DONE_DRAW_GAMEOVER: next_state = enter_pressed ? S_WAIT9 : DRAW_GAMEOVER;
				S_WAIT9: next_state = S_WAIT10;
				default:     next_state = S_WAIT10;
			endcase
	end
	
	// Output logic aka all of our datapath control signals
    always @(*)
    begin: enable_signals
        // By default make all our signals 0
		EraseState =1'b0;
		DrawPlayer =1'b0;
		DrawEnemy1 =1'b0;
		DrawEnemy2 =1'b0;
		DrawEnemy3 =1'b0;
		DrawEnemy4 =1'b0;
		DrawEnemy5 =1'b0;
		DrawGameoverState =1'b0;
		DrawStartScreenState =1'b0;
		Update=1'b0; // update for player
		UpdateEnemy1 =1'b0;
		UpdateEnemy2 =1'b0;
		UpdateEnemy3 =1'b0;
		UpdateEnemy4 =1'b0;
		UpdateEnemy5 =1'b0;
		detectCollide = 1'b0;
		Plot_on_VGA = 1'b0;
		object_to_draw = 4'b0110;
			   
		case(current_state)
			S_WAIT10: begin
				Plot_on_VGA = 1'b0;
			end
			
			ERASE_SCREEN: begin
				EraseState =1'b1;
				Plot_on_VGA = 1'b1;
				object_to_draw = 4'b1000;
			end
			
			S_WAIT16: begin
				EraseState =1'b0;
				Plot_on_VGA = 1'b1;
			end
			
			CHECK_COLLISION:begin
				detectCollide = 1'b1;
				Plot_on_VGA = 1'b0;
			end
			
			UPDATE_PLAYER: begin
				EraseState =1'b0;
				Update=1'b1;
				Plot_on_VGA = 1'b0;
				detectCollide = 1'b0;
			end
			
			DRAW_GAMEOVER: begin
				DrawGameoverState =1'b1;
				Plot_on_VGA = 1'b1;
				object_to_draw = 4'b0111;
				detectCollide = 1'b0;
			end
			
			DONE_DRAW_GAMEOVER: begin
				DrawGameoverState =1'b0;
				Plot_on_VGA = 1'b0;
			end
			
			S_WAIT9: begin
				DrawGameoverState =1'b0;
				Plot_on_VGA = 1'b0;
			end
			
			S_WAIT1: begin
				Update = 1'b0;
				Plot_on_VGA = 1'b0;
			end
			
			UPDATE_ENEMY1: begin
				UpdateEnemy1 =1'b1;
				Plot_on_VGA = 1'b0;
			end
			
			S_WAIT2: begin
				UpdateEnemy1 =1'b0;
				Plot_on_VGA = 1'b0;
			end
			
			UPDATE_ENEMY2: begin
				UpdateEnemy2 =1'b1;
				Plot_on_VGA = 1'b0;
			end
			
			S_WAIT11: begin
				UpdateEnemy2 =1'b0;
				Plot_on_VGA = 1'b0;
			end
			
			UPDATE_ENEMY3: begin
				UpdateEnemy3 =1'b1;
				Plot_on_VGA = 1'b0;
			end
			
			S_WAIT12: begin
				UpdateEnemy3 =1'b0;
				Plot_on_VGA = 1'b0;
			end
			
			UPDATE_ENEMY4: begin
				UpdateEnemy4 =1'b1;
				Plot_on_VGA = 1'b0;
			end
			
			S_WAIT13: begin
				UpdateEnemy4 =1'b0;
				Plot_on_VGA = 1'b0;
			end
			
			UPDATE_ENEMY5: begin
				UpdateEnemy5 =1'b1;
				Plot_on_VGA = 1'b0;
			end
			
			S_WAIT14: begin
				UpdateEnemy5 =1'b0;
				Plot_on_VGA = 1'b0;
			end
			
			DRAW_PLAYER: begin
				DrawPlayer =1'b1;
				Plot_on_VGA = 1'b1;
				object_to_draw = 4'b0101;
			end
			
			S_WAIT3: begin
				DrawPlayer =1'b0;
				Plot_on_VGA = 1'b0;
			end
			
			DRAW_ENEMY1: begin
				DrawEnemy1 = 1'b1;
				Plot_on_VGA = 1'b1;
				object_to_draw = 4'b0000;
			end
			
			S_WAIT4: begin
				DrawEnemy1 = 1'b0;
				Plot_on_VGA = 1'b0;
			end
			
			DRAW_ENEMY2: begin
				DrawEnemy2 = 1'b1;
				Plot_on_VGA = 1'b1;
				object_to_draw = 4'b0001;
			end
			
			S_WAIT5: begin
				DrawEnemy2 = 1'b0;
				Plot_on_VGA = 1'b0;
			end
			
			DRAW_ENEMY3: begin
				DrawEnemy3 = 1'b1;
				Plot_on_VGA = 1'b1;
				object_to_draw = 4'b0010;
			end
			
			S_WAIT6: begin
				DrawEnemy3 = 1'b0;
				Plot_on_VGA = 1'b0;
			end
			
			DRAW_ENEMY4: begin
				DrawEnemy4 = 1'b1;
				Plot_on_VGA = 1'b1;
				object_to_draw = 4'b0011;
			end
			
			S_WAIT7: begin
				DrawEnemy4 = 1'b0;
				Plot_on_VGA = 1'b0;
			end
			
			DRAW_ENEMY5: begin
				DrawEnemy5 = 1'b1;
				Plot_on_VGA = 1'b1;
				object_to_draw = 4'b0100;
			end
			
			S_WAIT8: begin
				DrawEnemy5 = 1'b0;
				Plot_on_VGA = 1'b0;
			end
		endcase
	end

    // current_state registers
    always@(posedge clk)
    begin: state_FFs
        if(resetn == 1'b0)begin
            current_state <= S_WAIT10;
		end
        else
            current_state <= next_state;
    end // state_FFS
endmodule
			   