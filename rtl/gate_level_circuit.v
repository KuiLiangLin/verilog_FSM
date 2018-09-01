`timescale 1ns/1ps
module Gate_Level(clk, in, out, rstn );
input wire clk, in, rstn;
output reg out;

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

wire out_pre = QA & in & (~QB);

always@(posedge clk, negedge rstn)
begin
	if(!rstn) 	out <= 1'b0;
	else 		out <= out_pre;
end


//endmodule
endmodule
