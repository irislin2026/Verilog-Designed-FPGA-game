module enemyDatapath1(
    input clk, reset,
    input UpdateEnemy1,
	 input space_pressed,
    output [2:0] enemy1_colour,
    output reg doneUpdateEnemy1,
    output reg [7:0] enemy1_x,
    output reg [6:0] enemy1_y
);

    localparam x = 8'd140;
    localparam y = 7'd10;
    localparam LeftLimit = 8'd0;
    localparam RightLimit = 8'd159;
	 
    reg [17:0] rateDividerCounter;         
    assign enemy1_colour = 3'b100;

    always @(posedge clk) begin
        if ((reset == 1'b0) || space_pressed) begin
            enemy1_x <= x;
            enemy1_y <= y;
            doneUpdateEnemy1 <= 1'b0;
            rateDividerCounter <= 22'd0;
				
		  end else if (!UpdateEnemy1) begin
				doneUpdateEnemy1 <= 1'b0;
				
        end else if (UpdateEnemy1) begin
            if ((enemy1_x == LeftLimit) && (rateDividerCounter == 18'd250000)) begin
                enemy1_x <= RightLimit;
                doneUpdateEnemy1 <= 1'b1;
                rateDividerCounter <= 18'd0;
            end else if ((enemy1_x != LeftLimit) && (rateDividerCounter == 18'd250000)) begin
                enemy1_x <= enemy1_x - 1;
                doneUpdateEnemy1 <= 1'b1;
                rateDividerCounter <= 18'd0;
            end else if (rateDividerCounter != 18'd250000) begin
                rateDividerCounter <= rateDividerCounter + 1;
					 doneUpdateEnemy1 <= 1'b0;
            end
        end
    end

endmodule
