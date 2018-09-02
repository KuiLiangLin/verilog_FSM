`timescale 1ns/1ps
`define CYCLE 100
module test_bench ();

//**************************** wire & reg**********************//
initial begin
    $display("//***************************************");
    $display("//==top input : clk, in, rstn");
    $display("//==top output :  out, sync_out");
    $display("//***************************************");
    end
reg clk, in, rstn;
wire out, sync_out;

//**************************** module **********************//
initial begin $display("===module : FSM Mealy Moor Gate_Level"); end
//number of moor state = number of mealy state * number of output +1

//Mealy Machines tend to have less states
// Different outputs on arcs (n^2) rather than states (n)
// Moore Machines are safer to use
// Outputs change at clock edge (always one cycle later)
// In Mealy machines, input change can cause output change as soon as
//logic is done – a big problem when two machines are interconnected –
//asynchronous feedback
// Mealy Machines react faster to inputs
// React in same cycle – don't need to wait for clock
// In Moore machines, more logic may be necessary to decode state
//into outputs – more gate delays after

// small fsm -> binary, gray code; big fsm -> one hot
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

//**************************** clock gen **********************//
initial begin
	$display("===starting generating clk");
	force clk = 1'b0;
	forever #(`CYCLE/2) force clk = ~clk;
	end

//**************************** initial and wavegen **********************//
initial begin
	$display("===starting dump waveform");
	$dumpfile("dump.vcd");
	$dumpvars(0,Moor);
	$dumpvars(0,Mealy);
	$dumpvars(0,Gate_Level);
	$dumpvars(0,test_bench);
	end

initial begin
    rstn = 1;
    in = 0;
    end

//**************************** main **********************//
reg [13:0]index_2;
integer index_1;
initial begin

	RESET();

	for(index_2 = 14'd0; index_2 <= 14'd500; index_2 = index_2 + 14'd7)
	begin 
        for(index_1 = 0; index_1 <= 13; index_1 = index_1 + 1)
		begin
			force in = index_2[index_1];
			if (out_moor != sync_mealy_out) $display("Compare Error : mealy, moor");
			else if (out_moor != sync_out_gate_level ) $display("Compare Error : moor, gate_level");
			else if (sync_mealy_out != sync_out_gate_level ) $display("Compare Error : mealy, gate_level");
			//else $display("Compare OK");
			#`CYCLE;
        end
		$display("send : %d", index_2);
	end
	
	$display("===all done");
	#1000 $finish;
    end

task RESET;
begin
	force rstn = 0;
	#1_000;
	force rstn = 1;
	#1_000;
end	
endtask	
	
	
	
	
endmodule

