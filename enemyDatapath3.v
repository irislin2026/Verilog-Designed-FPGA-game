module enemyDatapath3(
    input clk, reset,
    input UpdateEnemy3,
	 input space_pressed,
    output [2:0] enemy3_colour,
    output reg doneUpdateEnemy3,
    output reg [7:0] enemy3_x,
    output reg [6:0] enemy3_y
);

    localparam x = 8'd110;
    localparam y = 7'd60;
    localparam LeftLimit = 8'd0;
    localparam RightLimit = 8'd159;
	 
    reg [17:0] rateDividerCounter;         
    assign enemy3_colour = 3'b100;

    always @(posedge clk) begin
        if ((reset == 1'b0) || space_pressed) begin
            enemy3_x <= x;
            enemy3_y <= y;
            doneUpdateEnemy3 <= 1'b0;
            rateDividerCounter <= 22'd0;
				
		  end else if (!UpdateEnemy3) begin
				doneUpdateEnemy3 <= 1'b0;
				
        end else if (UpdateEnemy3) begin
            if ((enemy3_x == LeftLimit) && (rateDividerCounter == 18'd250000)) begin
                enemy3_x <= RightLimit;
                doneUpdateEnemy3 <= 1'b1;
                rateDividerCounter <= 18'd0;
            end else if ((enemy3_x != LeftLimit) && (rateDividerCounter == 18'd250000)) begin
                enemy3_x <= enemy3_x - 1;
                doneUpdateEnemy3 <= 1'b1;
                rateDividerCounter <= 18'd0;
            end else if (rateDividerCounter != 18'd250000) begin
                rateDividerCounter <= rateDividerCounter + 1;
					 doneUpdateEnemy3 <= 1'b0;
            end
        end
    end

endmodule
