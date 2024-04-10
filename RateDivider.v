module RateDivider #(parameter CLOCK_FREQUENCY = 50000000) (

	input ClockIn,          // input clock signal
	input Reset,            // reset signal
	input [1:0] Speed,      // two bit input to specify the division factor
	output Enable );        // output signal

	reg [31:0] counter;     // huge counter to keep track of the division

	always @(posedge ClockIn or posedge Reset)
  
	begin
		if (!Reset)
	 
		begin
			counter <= 0;      // resetting the counter to zero when Reset is one
		end
	 
		else
	 
		begin
			case(Speed)
				// counter changes every clock cycle when Speed is '00'
				2'b00: counter <= 0;
			
				// counter changes every second when Speed is '01'
				2'b01: counter <= (counter == 0) ? (CLOCK_FREQUENCY/1000000 - 1) : (counter - 1'b1);
			
				// counter changes every two seconds when Speed is '10'
				2'b10: counter <= (counter == 0) ? ((CLOCK_FREQUENCY * 2) - 1) : (counter - 1'b1);
			
				// counter changes every four seconds when Speed is '11'
				2'b11: counter <= (counter == 0) ? ((CLOCK_FREQUENCY * 4) - 1) : (counter - 1'b1);  
			endcase 
		end 
    end

  assign Enable = (counter == 0) ? 1'b1 : 1'b0; // setting Enable to one when the division factor is reached

endmodule