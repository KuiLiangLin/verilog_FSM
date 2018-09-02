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
//Mealy FSM的輸出直接受輸入訊號的當前值影響，
//而輸入訊號可能在一個時鐘周期內任意時刻變化，
//這使得Mealy FSM對輸入的響應發生在當前時鐘周期，
//比Moore有限狀態機對輸入訊號的響應要早一個周期。
//因此，輸入訊號的雜訊可能影響在輸出的訊號。
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

