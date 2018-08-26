`timescale 1ns/1ps
module Mealy(clk, in, out, rstn );
input wire clk, in, rstn;
output reg out;
 
reg[1:0] state;
parameter S0 = 2'd0, S1 = 2'd1, S2 = 2'd2;

always@ (posedge clk, negedge rstn)
begin
	if (!rstn)
		begin
		out <= 1'd0;
		state <= S0;	
		end
	else
		case(state)
			S0: if(in == 1'd0)
					begin 
					out <= 1'd0;
					state <= S0;
					end
				else 
					begin
					out <= 1'd0;
					state <= S1;				
					end
			S1: if(in == 1'd0)
					begin 
					out <= 1'd0;
					state <= S2;
					end
				else 
					begin
					out <= 1'd0;
					state <= S1;				
					end 
			S2: if(in == 1'd0)
					begin 
					out <= 1'd0;
					state <= S0;
					end
				else 
					begin
					out <= 1'd1;
					state <= S2;				
					end
		endcase
end 
//endmodule 
endmodule
