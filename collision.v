module collision(
	input clk, reset,
	input detectCollide,
	input space_pressed,
	input [7:0] player_x,
	input [6:0] player_y,
	input [7:0] enemy1_x,
	input [6:0] enemy1_y,
	input [7:0] enemy2_x,
	input [6:0] enemy2_y,
	input [7:0] enemy3_x,
	input [6:0] enemy3_y,
	input [7:0] enemy4_x,
	input [6:0] enemy4_y,
	input [7:0] enemy5_x,
	input [6:0] enemy5_y,
	output reg doneDetect,
	output reg collide);
	always@(posedge clk)begin
		if(reset == 1'b0 || space_pressed)begin
			doneDetect <= 1'b0;
			collide <= 1'b0;
		end else if (!detectCollide) begin
			doneDetect <= 1'b0;
		end else if (detectCollide) begin
				 collide <=(((player_x == (enemy1_x + 0) % 160) && (player_y == (enemy1_y + 0) % 120)) ||
								((player_x == (enemy1_x + 1) % 160) && (player_y == (enemy1_y + 0) % 120)) ||
								((player_x == (enemy1_x + 2) % 160) && (player_y == (enemy1_y + 0) % 120)) ||
								((player_x == (enemy1_x + 3) % 160) && (player_y == (enemy1_y + 0) % 120)) ||

								((player_x == (enemy1_x + 0) % 160) && (player_y == (enemy1_y + 1) % 120)) ||
								((player_x == (enemy1_x + 1) % 160) && (player_y == (enemy1_y + 1) % 120)) ||
								((player_x == (enemy1_x + 2) % 160) && (player_y == (enemy1_y + 1) % 120)) ||
								((player_x == (enemy1_x + 3) % 160) && (player_y == (enemy1_y + 1) % 120)) ||

								((player_x == (enemy1_x + 0) % 160) && (player_y == (enemy1_y + 2) % 120)) ||
								((player_x == (enemy1_x + 1) % 160) && (player_y == (enemy1_y + 2) % 120)) ||
								((player_x == (enemy1_x + 2) % 160) && (player_y == (enemy1_y + 2) % 120)) ||
								((player_x == (enemy1_x + 3) % 160) && (player_y == (enemy1_y + 2) % 120)) ||

								((player_x == (enemy1_x + 0) % 160) && (player_y == (enemy1_y + 3) % 120)) ||
								((player_x == (enemy1_x + 1) % 160) && (player_y == (enemy1_y + 3) % 120)) ||
								((player_x == (enemy1_x + 2) % 160) && (player_y == (enemy1_y + 3) % 120)) ||
								((player_x == (enemy1_x + 3) % 160) && (player_y == (enemy1_y + 3) % 120)) ||
								
								
								((player_x == (enemy2_x + 0) % 160) && (player_y == (enemy2_y + 0) % 120)) ||
								((player_x == (enemy2_x + 1) % 160) && (player_y == (enemy2_y + 0) % 120)) ||
								((player_x == (enemy2_x + 2) % 160) && (player_y == (enemy2_y + 0) % 120)) ||
								((player_x == (enemy2_x + 3) % 160) && (player_y == (enemy2_y + 0) % 120)) ||

								((player_x == (enemy2_x + 0) % 160) && (player_y == (enemy2_y + 1) % 120)) ||
								((player_x == (enemy2_x + 1) % 160) && (player_y == (enemy2_y + 1) % 120)) ||
								((player_x == (enemy2_x + 2) % 160) && (player_y == (enemy2_y + 1) % 120)) ||
								((player_x == (enemy2_x + 3) % 160) && (player_y == (enemy2_y + 1) % 120)) ||

								((player_x == (enemy2_x + 0) % 160) && (player_y == (enemy2_y + 2) % 120)) ||
								((player_x == (enemy2_x + 1) % 160) && (player_y == (enemy2_y + 2) % 120)) ||
								((player_x == (enemy2_x + 2) % 160) && (player_y == (enemy2_y + 2) % 120)) ||
								((player_x == (enemy2_x + 3) % 160) && (player_y == (enemy2_y + 2) % 120)) ||

								((player_x == (enemy2_x + 0) % 160) && (player_y == (enemy2_y + 3) % 120)) ||
								((player_x == (enemy2_x + 1) % 160) && (player_y == (enemy2_y + 3) % 120)) ||
								((player_x == (enemy2_x + 2) % 160) && (player_y == (enemy2_y + 3) % 120)) ||
								((player_x == (enemy2_x + 3) % 160) && (player_y == (enemy2_y + 3) % 120)) ||
								
								
								((player_x == (enemy3_x + 0) % 160) && (player_y == (enemy3_y + 0) % 120)) ||
								((player_x == (enemy3_x + 1) % 160) && (player_y == (enemy3_y + 0) % 120)) ||
								((player_x == (enemy3_x + 2) % 160) && (player_y == (enemy3_y + 0) % 120)) ||
								((player_x == (enemy3_x + 3) % 160) && (player_y == (enemy3_y + 0) % 120)) ||

								((player_x == (enemy3_x + 0) % 160) && (player_y == (enemy3_y + 1) % 120)) ||
								((player_x == (enemy3_x + 1) % 160) && (player_y == (enemy3_y + 1) % 120)) ||
								((player_x == (enemy3_x + 2) % 160) && (player_y == (enemy3_y + 1) % 120)) ||
								((player_x == (enemy3_x + 3) % 160) && (player_y == (enemy3_y + 1) % 120)) ||

								((player_x == (enemy3_x + 0) % 160) && (player_y == (enemy3_y + 2) % 120)) ||
								((player_x == (enemy3_x + 1) % 160) && (player_y == (enemy3_y + 2) % 120)) ||
								((player_x == (enemy3_x + 2) % 160) && (player_y == (enemy3_y + 2) % 120)) ||
								((player_x == (enemy3_x + 3) % 160) && (player_y == (enemy3_y + 2) % 120)) ||

								((player_x == (enemy3_x + 0) % 160) && (player_y == (enemy3_y + 3) % 120)) ||
								((player_x == (enemy3_x + 1) % 160) && (player_y == (enemy3_y + 3) % 120)) ||
								((player_x == (enemy3_x + 2) % 160) && (player_y == (enemy3_y + 3) % 120)) ||
								((player_x == (enemy3_x + 3) % 160) && (player_y == (enemy3_y + 3) % 120)) ||
								
								
								((player_x == (enemy4_x + 0) % 160) && (player_y == (enemy4_y + 0) % 120)) ||
								((player_x == (enemy4_x + 1) % 160) && (player_y == (enemy4_y + 0) % 120)) ||
								((player_x == (enemy4_x + 2) % 160) && (player_y == (enemy4_y + 0) % 120)) ||
								((player_x == (enemy4_x + 3) % 160) && (player_y == (enemy4_y + 0) % 120)) ||

								((player_x == (enemy4_x + 0) % 160) && (player_y == (enemy4_y + 1) % 120)) ||
								((player_x == (enemy4_x + 1) % 160) && (player_y == (enemy4_y + 1) % 120)) ||
								((player_x == (enemy4_x + 2) % 160) && (player_y == (enemy4_y + 1) % 120)) ||
								((player_x == (enemy4_x + 3) % 160) && (player_y == (enemy4_y + 1) % 120)) ||

								((player_x == (enemy4_x + 0) % 160) && (player_y == (enemy4_y + 2) % 120)) ||
								((player_x == (enemy4_x + 1) % 160) && (player_y == (enemy4_y + 2) % 120)) ||
								((player_x == (enemy4_x + 2) % 160) && (player_y == (enemy4_y + 2) % 120)) ||
								((player_x == (enemy4_x + 3) % 160) && (player_y == (enemy4_y + 2) % 120)) ||

								((player_x == (enemy4_x + 0) % 160) && (player_y == (enemy4_y + 3) % 120)) ||
								((player_x == (enemy4_x + 1) % 160) && (player_y == (enemy4_y + 3) % 120)) ||
								((player_x == (enemy4_x + 2) % 160) && (player_y == (enemy4_y + 3) % 120)) ||
								((player_x == (enemy4_x + 3) % 160) && (player_y == (enemy4_y + 3) % 120))||
								
								
								((player_x == (enemy5_x + 0) % 160) && (player_y == (enemy5_y + 0) % 120)) ||
								((player_x == (enemy5_x + 1) % 160) && (player_y == (enemy5_y + 0) % 120)) ||
								((player_x == (enemy5_x + 2) % 160) && (player_y == (enemy5_y + 0) % 120)) ||
								((player_x == (enemy5_x + 3) % 160) && (player_y == (enemy5_y + 0) % 120)) ||

								((player_x == (enemy5_x + 0) % 160) && (player_y == (enemy5_y + 1) % 120)) ||
								((player_x == (enemy5_x + 1) % 160) && (player_y == (enemy5_y + 1) % 120)) ||
								((player_x == (enemy5_x + 2) % 160) && (player_y == (enemy5_y + 1) % 120)) ||
								((player_x == (enemy5_x + 3) % 160) && (player_y == (enemy5_y + 1) % 120)) ||

								((player_x == (enemy5_x + 0) % 160) && (player_y == (enemy5_y + 2) % 120)) ||
								((player_x == (enemy5_x + 1) % 160) && (player_y == (enemy5_y + 2) % 120)) ||
								((player_x == (enemy5_x + 2) % 160) && (player_y == (enemy5_y + 2) % 120)) ||
								((player_x == (enemy5_x + 3) % 160) && (player_y == (enemy5_y + 2) % 120)) ||

								((player_x == (enemy5_x + 0) % 160) && (player_y == (enemy5_y + 3) % 120)) ||
								((player_x == (enemy5_x + 1) % 160) && (player_y == (enemy5_y + 3) % 120)) ||
								((player_x == (enemy5_x + 2) % 160) && (player_y == (enemy5_y + 3) % 120)) ||
								((player_x == (enemy5_x + 3) % 160) && (player_y == (enemy5_y + 3) % 120)));
					doneDetect <= 1'b1;
			end
	end
													
endmodule
