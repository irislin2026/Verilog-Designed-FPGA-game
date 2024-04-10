module enemyDatapath2(
    input clk, reset,
    input UpdateEnemy2,
	 input space_pressed,
    output [2:0] enemy2_colour,
    output reg doneUpdateEnemy2,
    output reg [7:0] enemy2_x,
    output reg [6:0] enemy2_y
);

    localparam x = 8'd120;
    localparam y = 7'd35;
    localparam LeftLimit = 8'd0;
    localparam RightLimit = 8'd159;
	 
    reg [17:0] rateDividerCounter;         
    assign enemy2_colour = 3'b100;

    always @(posedge clk) begin
        if ((reset == 1'b0) || space_pressed) begin
            enemy2_x <= x;
            enemy2_y <= y;
            doneUpdateEnemy2 <= 1'b0;
            rateDividerCounter <= 22'd0;
				
		  end else if (!UpdateEnemy2) begin
				doneUpdateEnemy2 <= 1'b0;
				
        end else if (UpdateEnemy2) begin
            if ((enemy2_x == LeftLimit) && (rateDividerCounter == 18'd250000)) begin
                enemy2_x <= RightLimit;
                doneUpdateEnemy2 <= 1'b1;
                rateDividerCounter <= 18'd0;
            end else if ((enemy2_x != LeftLimit) && (rateDividerCounter == 18'd250000)) begin
                enemy2_x <= enemy2_x - 1;
                doneUpdateEnemy2 <= 1'b1;
                rateDividerCounter <= 18'd0;
            end else if (rateDividerCounter != 18'd250000) begin
                rateDividerCounter <= rateDividerCounter + 1;
					 doneUpdateEnemy2 <= 1'b0;
            end
        end
    end

endmodule
