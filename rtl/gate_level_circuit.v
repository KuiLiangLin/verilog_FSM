`timescale 1ns/1ps
module Gate_Level(clk, in, out, rstn );
input wire clk, in, rstn;
output wire out;

reg QA, QB; 
 
always@(posedge clk, negedge rstn)
begin
	if(!rstn) 	QB <= 1'b0;
	else 		QB <= in;
end

wire DA = QB & (~in);

always@(posedge clk, negedge rstn)
begin
	if(!rstn) 	QA <= 1'b0;
	else 		QA <= DA;
end

assign out = QA & in;

//endmodule
endmodule
