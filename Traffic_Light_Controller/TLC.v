module TLC(clk,light);
input clk;
output reg [2:0] light;

parameter S0=0, S1=1, S2=2;
parameter RED=3'b100, YELLOW=3'b010, GREEN=3'b001;

reg [1:0] state;

always @(posedge clk)
	case (state)
		S0: begin // S0 means RED
			light <= YELLOW; state <= S1;
		end

		S1: begin // S1 means YELLOW
			light <= GREEN; state <= S2;
		end

		S2: begin // S2 means GREEN
			light <= RED; state <= S0;
		end

		default: begin
			light <= RED;
			state <= S0;
		end
	endcase

endmodule

