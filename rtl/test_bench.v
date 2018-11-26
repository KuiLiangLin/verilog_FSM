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
wire out_moor;
wire out_mealy, sync_mealy_out;
wire out_gate_level, sync_out_gate_level;

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

top_digital top_digital(.rstn(rstn),
						.clk(clk),
						.in(in), 
						.out_moor(out_moor),
						.out_mealy(out_mealy),
						.sync_mealy_out(sync_mealy_out),					
						.out_gate_level(out_gate_level),
						.sync_out_gate_level(sync_out_gate_level)					
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
	$dumpvars(0,top_digital);
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

	for(index_2 = 14'd0; index_2 <= 14'd500; index_2 = index_2 + 14'd1)
	begin 
        for(index_1 = 0; index_1 <= 13; index_1 = index_1 + 1)
		begin
			force in = index_2[index_1];
			if (out_moor != sync_mealy_out) 
				$display("Compare Error : mealy, moor @ %t,", $time);
			else if (out_moor != sync_out_gate_level ) 
				$display("Compare Error : moor, gate_level @ %t,", $time);
			else if (sync_mealy_out != sync_out_gate_level ) 
				$display("Compare Error : mealy, gate_level @ %t,", $time);
			//else $display("Compare OK");
			#`CYCLE;
        end
		
		if (index_2%14'd64 == 0)
		begin 
		$display("send : 0x%h, the time is %t", index_2, $time); 
		end
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

