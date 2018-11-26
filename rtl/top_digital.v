`timescale 1ns/1ps

module top_digital(clk, in, rstn,
					out_moor, out_mealy, sync_mealy_out,
					out_gate_level, sync_out_gate_level);
					
input wire clk, in, rstn; 
output wire out_moor;
output wire out_mealy, sync_mealy_out;
output wire out_gate_level, sync_out_gate_level;

Moor Moor(.rstn(rstn),
			.clk(clk),
			.in(in), 
			.out(out_moor)
);

Mealy Mealy(.rstn(rstn),
			.clk(clk),
			.in(in), 
			.out(out_mealy),
			.sync_out(sync_mealy_out)
);

Gate_Level Gate_Level(.rstn(rstn),
			.clk(clk),
			.in(in), 
			.out(out_gate_level),
			.sync_out(sync_out_gate_level)
);
 
endmodule
