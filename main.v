module main(CLOCK_50 ,HEX1,HEX0, KEY, LEDR, PS2_CLK, PS2_DAT, VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N, VGA_R, VGA_G, VGA_B);
	input CLOCK_50; //clk
	input [3:0] KEY; // for reset
	
	//keyboard
	//input PS2_CLK, PS2_DAT; 
	wire left_pressed, right_pressed, up_pressed, down_pressed, space_pressed, enter_pressed, key_pressed;
	inout PS2_CLK;
	inout PS2_DAT;
	output [9:0] LEDR;
	wire [7:0] ps2_key_data;
	wire EraseState;
	
	
	keyboard key(
	.clk(CLOCK_50), 
	.reset(KEY[0]),
	.EraseState(EraseState),
	.PS2_CLK(PS2_CLK),
	.PS2_DAT(PS2_DAT),
	.ps2_key_data(ps2_key_data),
	.up_pressed(up_pressed), 
	.down_pressed(down_pressed), 
	.left_pressed(left_pressed), 
	.right_pressed(right_pressed),
	.space_pressed(space_pressed), 
	.enter_pressed(enter_pressed),
	);
	
	 
	
	//playerControl
	wire inputstate, update_player, setleft, setright, setup, setdown, doneUpdate_player;
	
	playerControl u1(
	.clk(CLOCK_50),
	.reset_n(KEY[0]),
	.left_pressed(left_pressed), 
	.right_pressed(right_pressed), 
	.up_pressed(up_pressed), .down_pressed(down_pressed),
	.doneUpdate_player(doneUpdate_player),
	.inputState(inputstate), 
	.update_player(update_player), 
	.setleft(setleft), 
	.setright(setright), 
	.setup(setup), 
	.setdown(setdown)
	);
	
	//playerDatapath Updateplayer
	wire update; // FSM
	wire [7:0] original_player_x; //fromdraw
	wire [6:0] original_player_y;
	wire [7:0] player_x; // to drawplayer
	wire [6:0] player_y; 
	wire [2:0]playercolour;
	wire [7:0] playerxerase;
	wire [6:0] playeryerase;
	wire eraseplayer;
	
	playerDatapath u2(
	.clk(CLOCK_50), 
	.reset(KEY[0]), 
	.left_pressed(left_pressed), 
	.right_pressed(right_pressed), 
	.up_pressed(up_pressed), 
	.down_pressed(down_pressed),
	.update(update), //from drawFSM
	.original_player_x(original_player_x), //original position pixel
	.original_player_y(original_player_y),
	.EraseState(EraseState),
	.doneUpdate_player(doneUpdate_player), // to draw FSM
	.player_x(player_x), 
	.player_y(player_y),	//x and y position for drawplayer
	.playercolour(playercolour),
	.playerxerase(playerxerase),
	.playeryerase(playeryerase),
	.eraseplayer(eraseplayer)
	);
	
	//enemyDatapath1
	wire [2:0] enemy1_colour;
	wire [7:0] enemy1_x;
	wire [6:0] enemy1_y;
	wire doneUpdateEnemy1, UpdateEnemy1; //FSM
	
	enemyDatapath1 e1(
    .clk(CLOCK_50),
	.reset(KEY[0]),
    .UpdateEnemy1(UpdateEnemy1),
	.space_pressed(space_pressed),
	.enemy1_colour(enemy1_colour),
    .doneUpdateEnemy1(doneUpdateEnemy1),
    .enemy1_x(enemy1_x),
    .enemy1_y(enemy1_y)
	);
	
	//enemyDatapath2
	wire [2:0] enemy2_colour;
	wire [7:0] enemy2_x;
	wire [6:0] enemy2_y;
	wire doneUpdateEnemy2, UpdateEnemy2; //FSM
	
	enemyDatapath2 e2(
    .clk(CLOCK_50),
	.reset(KEY[0]),
    .UpdateEnemy2(UpdateEnemy2),
	.space_pressed(space_pressed),
	.enemy2_colour(enemy2_colour),
    .doneUpdateEnemy2(doneUpdateEnemy2),
    .enemy2_x(enemy2_x),
    .enemy2_y(enemy2_y)
	);
	
	//enemyDatapath3
	wire [2:0] enemy3_colour;
	wire [7:0] enemy3_x;
	wire [6:0] enemy3_y;
	wire doneUpdateEnemy3, UpdateEnemy3; //FSM
	
	enemyDatapath3 e3(
    .clk(CLOCK_50),
	.reset(KEY[0]),
    .UpdateEnemy3(UpdateEnemy3),
	.space_pressed(space_pressed),
	.enemy3_colour(enemy3_colour),
    .doneUpdateEnemy3(doneUpdateEnemy3),
    .enemy3_x(enemy3_x),
    .enemy3_y(enemy3_y)
	);
	
	//enemyDatapath4
	wire [2:0] enemy4_colour;
	wire [7:0] enemy4_x;
	wire [6:0] enemy4_y;
	wire doneUpdateEnemy4, UpdateEnemy4; //FSM
	
	enemyDatapath4 e4(
    .clk(CLOCK_50),
	.reset(KEY[0]),
    .UpdateEnemy4(UpdateEnemy4),
	.space_pressed(space_pressed),
	.enemy4_colour(enemy4_colour),
    .doneUpdateEnemy4(doneUpdateEnemy4),
    .enemy4_x(enemy4_x),
    .enemy4_y(enemy4_y)
	);
	
	//enemyDatapath5
	wire [2:0] enemy5_colour;
	wire [7:0] enemy5_x;
	wire [6:0] enemy5_y;
	wire doneUpdateEnemy5, UpdateEnemy5; //FSM
	
	enemyDatapath5 e5(
    .clk(CLOCK_50),
	.reset(KEY[0]),
    .UpdateEnemy5(UpdateEnemy5),
	.space_pressed(space_pressed),
	.enemy5_colour(enemy5_colour),
    .doneUpdateEnemy5(doneUpdateEnemy5),
    .enemy5_x(enemy5_x),
    .enemy5_y(enemy5_y)
	);
	//drawFSM
	wire doneDrawStart, doneDrawPlayer, doneDrawEnemy1,doneDrawEnemy2, 
		doneDrawEnemy3, doneDrawEnemy4,doneDrawEnemy5, doneDrawGameover, doneErasing, doneDetect;
	wire collide;
	wire [3:0]object_to_draw;
	wire Plot_on_VGA;
	wire DrawPlayer, DrawEnemy1, DrawEnemy2, DrawEnemy3, DrawEnemy4, DrawEnemy5,
			DrawGameoverState, DrawStartScreenState, detectCollide;
	
	drawFSM f1(	
	.clk(CLOCK_50), .resetn(KEY[0]), .collide(collide), .space_pressed(space_pressed), .enter_pressed(enter_pressed), 
	.doneDrawStart(doneDrawStart), .doneDrawPlayer(doneDrawPlayer), .doneDrawEnemy1(doneDrawEnemy1),
	.doneDrawEnemy2(doneDrawEnemy2), .doneDrawEnemy3(doneDrawEnemy3), .doneDrawEnemy4(doneDrawEnemy4),
	.doneDrawEnemy5(doneDrawEnemy5), .doneDrawGameover(doneDrawGameover), .doneErasing(doneErasing), .donedetect(doneDetect),
	.doneUpdate_player(doneUpdate_player), .doneUpdate_enemy1(doneUpdateEnemy1), 
	.doneUpdate_enemy2(doneUpdateEnemy2), .doneUpdate_enemy3(doneUpdateEnemy3), 
	.doneUpdate_enemy4(doneUpdateEnemy4), .doneUpdate_enemy5(doneUpdateEnemy5),
	.object_to_draw(object_to_draw),
	.Plot_on_VGA(Plot_on_VGA), 
	.EraseState(EraseState), .DrawPlayer(DrawPlayer), .DrawEnemy1(DrawEnemy1), .DrawEnemy2(DrawEnemy2), 
	.DrawEnemy3(DrawEnemy3), .DrawEnemy4(DrawEnemy4), .DrawEnemy5(DrawEnemy5),
	.DrawGameoverState(DrawGameoverState), .DrawStartScreenState(DrawStartScreenState),
	.Update(update), .UpdateEnemy1(UpdateEnemy1), .UpdateEnemy2(UpdateEnemy2), .UpdateEnemy3(UpdateEnemy3),
	.UpdateEnemy4(UpdateEnemy4), .UpdateEnemy5(UpdateEnemy5), .detectCollide(detectCollide)
	);
				
	//collision
	collision c1(
	.clk(CLOCK_50), .reset(KEY[0]),
	.space_pressed(space_pressed),
	.player_x(player_x),
	.player_y(player_y),
	.enemy1_x(enemy1_x),
	.enemy1_y(enemy1_y),
	.enemy2_x(enemy2_x),
	.enemy2_y(enemy2_y),
	.enemy3_x(enemy3_x),
	.enemy3_y(enemy3_y),
	.enemy4_x(enemy4_x),
	.enemy4_y(enemy4_y),
	.enemy5_x(enemy5_x),
	.enemy5_y(enemy5_y),
	.detectCollide(detectCollide),
	.doneDetect(doneDetect),
	.collide(collide));
	
	//drawStart
	wire [2:0]startcolour;
	wire [7:0] start_x;
	wire [6:0] start_y;
	drawStart d1(	
	.clk(CLOCK_50), .reset(KEY[0]),
	.DrawStartScreenState(DrawStartScreenState),
	.VGA_Colour(startcolour),// VGA pixel colour (RGB)
	.VGA_x(start_x), 
	.VGA_y(start_y),
	.doneDrawStart(doneDrawStart)
	);
	
	//drawGameover
	wire [2:0]gameovercolour;
	wire [7:0] gameover_x;
	wire [6:0] gameover_y;
	drawGameover d2(	
	.clk(CLOCK_50), 
	.reset(KEY[0]),
	.DrawGameoverState(DrawGameoverState),
	.VGA_Colour(gameovercolour),// VGA pixel colour (RGB)
	.VGA_x(gameover_x), 
	.VGA_y(gameover_y),
	.doneDrawGameover(doneDrawGameover)
	);
	
	//drawplayer
	wire [2:0]playercolour_VGA; 
	wire [7:0] VGA_playerx;
	wire [6:0] VGA_playery;
	drawplayer u3(
	.clk(CLOCK_50), 
	.reset(KEY[0]),
	.player_x(player_x),// from datapath (also to VGA)
	.player_y(player_y),//from datapath
	.playercolour(playercolour),//from datapath
	.DrawPlayer(DrawPlayer), // from FSM
	.EraseState(EraseState),
	.playerxerase(playerxerase),
	.playeryerase(playeryerase),
	.eraseplayer(eraseplayer),
	.VGA_Colour(playercolour_VGA),// VGA pixel colour (RGB)
	.donedraw(doneDrawPlayer),//to FSM
	.original_player_x(original_player_x),
	.original_player_y(original_player_y),
	.VGA_X(VGA_playerx),
	.VGA_Y(VGA_playery)
	);
	
	//drawenemy1
	wire [2:0]enemycolour1;
	wire [7:0] VGA_enemy1x;
	wire [6:0] VGA_enemy1y;
	drawenemy1 d4(
	.clk(CLOCK_50), 
	.reset(KEY[0]),
	.space_pressed(space_pressed),
	.enemy1_x(enemy1_x),// from datapath (also to VGA)
	.enemy1_y(enemy1_y),//from datapath
	.enemy1colour(enemy1_colour),//from datapath
	.drawEnemy1(DrawEnemy1), // from fsm
	.VGA_Colour(enemycolour1),// VGA pixel colour (RGB)
	.doneDrawEnemy1(doneDrawEnemy1),
	.xToDraw(VGA_enemy1x),
	.yToDraw(VGA_enemy1y)
	);
	//drawenemy2
	wire [2:0]enemycolour2;
	wire [7:0] VGA_enemy2x;
	wire [6:0] VGA_enemy2y;
	drawenemy2 d5(
	.clk(CLOCK_50), 
	.reset(KEY[0]),
	.space_pressed(space_pressed),
	.enemy2_x(enemy2_x),// from datapath (also to VGA)
	.enemy2_y(enemy2_y),//from datapath
	.enemy2colour(enemy2_colour),//from datapath
	.drawEnemy2(DrawEnemy2), // from fsm
	.VGA_Colour(enemycolour2),// VGA pixel colour (RGB)
	.doneDrawEnemy2(doneDrawEnemy2),
	.xToDraw(VGA_enemy2x),
	.yToDraw(VGA_enemy2y)
	);
	//drawenemy3
	wire [2:0]enemycolour3;
	wire [7:0] VGA_enemy3x;
	wire [6:0] VGA_enemy3y;
	drawenemy3 d6(
	.clk(CLOCK_50), 
	.reset(KEY[0]),
	.space_pressed(space_pressed),
	.enemy3_x(enemy3_x),// from datapath (also to VGA)
	.enemy3_y(enemy3_y),//from datapath
	.enemy3colour(enemy3_colour),//from datapath
	.drawEnemy3(DrawEnemy3), // from fsm
	.VGA_Colour(enemycolour3),// VGA pixel colour (RGB)
	.doneDrawEnemy3(doneDrawEnemy3),
	.xToDraw(VGA_enemy3x),
	.yToDraw(VGA_enemy3y)
	);
	//drawenemy4
	wire [2:0]enemycolour4;
	wire [7:0] VGA_enemy4x;
	wire [6:0] VGA_enemy4y;
	drawenemy4 d7(
	.clk(CLOCK_50), 
	.reset(KEY[0]),
	.space_pressed(space_pressed),
	.enemy4_x(enemy4_x),// from datapath (also to VGA)
	.enemy4_y(enemy4_y),//from datapath
	.enemy4colour(enemy4_colour),//from datapath
	.drawEnemy4(DrawEnemy4), // from fsm
	.VGA_Colour(enemycolour4),// VGA pixel colour (RGB)
	.doneDrawEnemy4(doneDrawEnemy4),
	.xToDraw(VGA_enemy4x),
	.yToDraw(VGA_enemy4y)
	);
	//drawenemy5
	wire [2:0]enemycolour5;
	wire [7:0] VGA_enemy5x;
	wire [6:0] VGA_enemy5y;
	drawenemy5 d8(
	.clk(CLOCK_50), 
	.reset(KEY[0]),
	.space_pressed(space_pressed),
	.enemy5_x(enemy5_x),// from datapath (also to VGA)
	.enemy5_y(enemy5_y),//from datapath
	.enemy5colour(enemy5_colour),//from datapath
	.drawEnemy5(DrawEnemy5), // from fsm
	.VGA_Colour(enemycolour5),// VGA pixel colour (RGB)
	.doneDrawEnemy5(doneDrawEnemy5),
	.xToDraw(VGA_enemy5x),
	.yToDraw(VGA_enemy5y)
	);
	
	//erase
	wire [2:0]erasecolour;
	wire [7:0] erase_x;
	wire [6:0] erase_y;
	
	erase d3(	
	.clk(CLOCK_50), 
	.reset(KEY[0]),
	.EraseState(EraseState),
	.space_pressed(space_pressed),
	.VGA_Colour(erasecolour),// VGA pixel colour (RGB)
	.VGA_x(erase_x), 
	.VGA_y(erase_y),
	.doneErase(doneErasing)
	);
	
	//x_y_colourMux
	reg [2:0]VGA_colour;
	reg [7:0] VGA_x;
	reg [6:0] VGA_y;
	always @ (*)	
		begin
			if (DrawStartScreenState)begin
					VGA_x <= start_x;
					VGA_y <= start_y;
					VGA_colour <= startcolour;
				end
			else if (EraseState)begin
				VGA_x <= erase_x;
				VGA_y <= erase_y;
				VGA_colour <= erasecolour;
			end
			else if (DrawPlayer)begin
					VGA_x <= VGA_playerx;
					VGA_y <= VGA_playery;
					VGA_colour <= playercolour_VGA;
				end
			else if (DrawEnemy1) begin
					VGA_x <= VGA_enemy1x;
					VGA_y <= VGA_enemy1y;
					VGA_colour <= enemycolour1;
				end
			else if(DrawEnemy2)begin
					VGA_x <= VGA_enemy2x;
					VGA_y <= VGA_enemy2y;
					VGA_colour <= enemycolour2;
				end
			else if (DrawEnemy3)begin
					VGA_x <= VGA_enemy3x;
					VGA_y <= VGA_enemy3y;
					VGA_colour <= enemycolour3;
				end
			else if (DrawEnemy4)begin
					VGA_x <= VGA_enemy4x;
					VGA_y <= VGA_enemy4y;
					VGA_colour <= enemycolour4;
				end
			else if (DrawEnemy5)begin
					VGA_x <= VGA_enemy5x;
					VGA_y <= VGA_enemy5y;
					VGA_colour <= enemycolour5;
				end
			else if (DrawGameoverState)begin
					VGA_x <= gameover_x;
					VGA_y <= gameover_y;
					VGA_colour <= gameovercolour;
				end
		end
	
	
	//VGA_Adapter
	output VGA_CLK, VGA_HS, VGA_VS, VGA_BLANK_N, VGA_SYNC_N;
	output [7:0] VGA_R; 
	output [7:0] VGA_G; 
	output [7:0] VGA_B;
	vga_adapter(
			.resetn(KEY[0]),
			.clock(CLOCK_50),
			.colour(VGA_colour),
			.x(VGA_x), 
			.y(VGA_y), 
			.plot(Plot_on_VGA),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
			
		output [6:0] HEX1, HEX0;
	
	PS2_Demo ps2d(
	.CLOCK_50(CLOCK_50),
	.KEY(KEY),
	.LEDR(LEDR),
	.HEX1(HEX1), .HEX0(HEX0),
	.PS2_CLK(PS2_CLK),
	.PS2_DAT(PS2_DAT),
	);

endmodule
