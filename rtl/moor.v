`timescale 1ns/1ps
module Moor(clk, in, out, rstn );
input wire clk, in, rstn;
output wire out;
 
reg[1:0] state;
parameter S0 = 2'd0, S1 = 2'd1;
parameter S2 = 2'd2, S3 = 2'd3;

always@ (posedge clk, negedge rstn)
begin
if(!rstn)
	state <= S0;
else
	case(state)
		S0: if(in == 1'd1)  state <= S1;
			else 			state <= S0;					
		S1: if(in == 1'd0)  state <= S2;
			else 			state <= S0;
		S2: if(in == 1'd1)  state <= S3;
			else 			state <= S0;
		S3: if(in == 1'd1)  state <= S0;
			else 			state <= S2;			
	endcase
end 

assign out = (state == S3) ? 1'b1 : 1'b0;

//endmodule 
endmodule