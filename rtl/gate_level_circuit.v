`timescale 1ns/1ps
module Gate_Level(clk, in, out, rstn, sync_out );
input wire clk, in, rstn;
output reg  sync_out;
output wire out;

reg QA, QB; 
 
wire DB = in & (~QB); 
 
always@(posedge clk, negedge rstn)
begin
	if(!rstn) 	QB <= 1'b0;
	else 		QB <= DB;
end

wire DA = (QA & in & (~QB)) | (QB & (~in));

always@(posedge clk, negedge rstn)
begin
	if(!rstn) 	QA <= 1'b0;
	else 		QA <= DA;
end

assign out = QA & in & (~QB);

//synchronous mealy FSM
always@(posedge clk, negedge rstn)
begin
	if(!rstn) 	sync_out <= 1'b0;
	else 		sync_out <= out;
end


//endmodule
endmodule
