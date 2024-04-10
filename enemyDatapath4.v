module enemyDatapath4(
    input clk, reset,
    input UpdateEnemy4,
	 input space_pressed,
    output [2:0] enemy4_colour,
    output reg doneUpdateEnemy4,
    output reg [7:0] enemy4_x,
    output reg [6:0] enemy4_y
);

    localparam x = 8'd130;
    localparam y = 7'd85;
    localparam LeftLimit = 8'd0;
    localparam RightLimit = 8'd159;
	 
    reg [17:0] rateDividerCounter;         
    assign enemy4_colour = 3'b100;

    always @(posedge clk) begin
        if ((reset == 1'b0) || space_pressed) begin
            enemy4_x <= x;
            enemy4_y <= y;
            doneUpdateEnemy4 <= 1'b0;
            rateDividerCounter <= 22'd0;
				
		  end else if (!UpdateEnemy4) begin
				doneUpdateEnemy4 <= 1'b0;
				
        end else if (UpdateEnemy4) begin
            if ((enemy4_x == LeftLimit) && (rateDividerCounter == 18'd250000)) begin
                enemy4_x <= RightLimit;
                doneUpdateEnemy4 <= 1'b1;
                rateDividerCounter <= 18'd0;
            end else if ((enemy4_x != LeftLimit) && (rateDividerCounter == 18'd250000)) begin
                enemy4_x <= enemy4_x - 1;
                doneUpdateEnemy4 <= 1'b1;
                rateDividerCounter <= 18'd0;
            end else if (rateDividerCounter != 18'd250000) begin
                rateDividerCounter <= rateDividerCounter + 1;
					 doneUpdateEnemy4 <= 1'b0;
            end
        end
    end

endmodule
