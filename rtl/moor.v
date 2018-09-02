`timescale 1ns/1ps
module Moor(clk, in, out, rstn );
input wire clk, in, rstn;
output reg out;
 
reg [1:0]  state;
reg [1:0]  next_state;
parameter S0 = 2'd0, S1 = 2'd1;
parameter S2 = 2'd2, S3 = 2'd3;

always@ (posedge clk, negedge rstn)
begin
	if(!rstn)
		state <= S0;
	else
		state <= next_state;
end

always@(*)
begin
	case(state)
		S0: if(in == 1'd1)  next_state = S1;
			else 			next_state = S0;					
		S1: if(in == 1'd0)  next_state = S2;
			else 			next_state = S0;
		S2: if(in == 1'd1)  next_state = S3;
			else 			next_state = S0;
		S3: if(in == 1'd1)  next_state = S0;
			else 			next_state = S2;		
		default : 			next_state = S0;
	endcase
end

always@(*)
begin
	case(state)
		S0:   	  out = 0;
		S1:   	  out = 0;
		S2:		  out = 0;
		S3:		  out = 1;
		default : out = 0;
	endcase
end
//endmodule 
endmodule
