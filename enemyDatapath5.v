module enemyDatapath5(
    input clk, reset,
    input UpdateEnemy5,
	 input space_pressed,
    output [2:0] enemy5_colour,
    output reg doneUpdateEnemy5,
    output reg [7:0] enemy5_x,
    output reg [6:0] enemy5_y
);

    localparam x = 8'd150;
    localparam y = 7'd110;
    localparam LeftLimit = 8'd0;
    localparam RightLimit = 8'd159;
	 
    reg [17:0] rateDividerCounter;         
    assign enemy5_colour = 3'b100;

    always @(posedge clk) begin
        if ((reset == 1'b0) || space_pressed) begin
            enemy5_x <= x;
            enemy5_y <= y;
            doneUpdateEnemy5 <= 1'b0;
            rateDividerCounter <= 22'd0;
				
		  end else if (!UpdateEnemy5) begin
				doneUpdateEnemy5 <= 1'b0;
				
        end else if (UpdateEnemy5) begin
            if ((enemy5_x == LeftLimit) && (rateDividerCounter == 18'd250000)) begin
                enemy5_x <= RightLimit;
                doneUpdateEnemy5 <= 1'b1;
                rateDividerCounter <= 18'd0;
            end else if ((enemy5_x != LeftLimit) && (rateDividerCounter == 18'd250000)) begin
                enemy5_x <= enemy5_x - 1;
                doneUpdateEnemy5 <= 1'b1;
                rateDividerCounter <= 18'd0;
            end else if (rateDividerCounter != 18'd250000) begin
                rateDividerCounter <= rateDividerCounter + 1;
					 doneUpdateEnemy5 <= 1'b0;
            end
        end
    end

endmodule
