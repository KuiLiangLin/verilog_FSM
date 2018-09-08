# verilog_FSM

This is a basic project about FSM

if input sequence = 101, output = 1; else output = 0;

Basic Mealy FSM structure : 

<img src="https://raw.githubusercontent.com/KuiLiangLin/verilog_FSM/master/Mealy_FSM_Structure.jpg" height="100%" width="100%" >

According to Mealy FSM structure , we get Mealy FSM sequence :

<img src="https://raw.githubusercontent.com/KuiLiangLin/verilog_FSM/master/Mealy_FSM_Sequence.jpg" height="100%" width="100%" >

Basic Moore FSM structure : 

<img src="https://raw.githubusercontent.com/KuiLiangLin/verilog_FSM/master/Moore_FSM_Structure.jpg" height="100%" width="100%" >

According to Moore FSM structure , we get Moore FSM sequence :

<img src="https://raw.githubusercontent.com/KuiLiangLin/verilog_FSM/master/Moore_FSM_Sequence.jpg" height="100%" width="100%" >

According to the FSM sequence, we get truth table.

Because each bit of state is represented by a register, we know DA, DB, and output are fuction of QA, QB, and input.

Thus we use K-map to simplify them. 

<img src="https://raw.githubusercontent.com/KuiLiangLin/verilog_FSM/master/Truth_Table.jpg" height="100%" width="100%" >

After simplified by K-map, we get gate level circuit.

<img src="https://raw.githubusercontent.com/KuiLiangLin/verilog_FSM/master/Gate_Level_Curcuit.jpg" height="100%" width="100%" >

Test bench is used to see the comparision of output among Moore, Mealy, and equivalent gate level circuit.

<img src="https://raw.githubusercontent.com/KuiLiangLin/verilog_FSM/master/Waveform.JPG" height="100%" width="100%" >


Conclusion : 

1. number of moor state = number of mealy state * number of output +1

2. Moore Machines are safer to use : 

   - Outputs change at clock edge (always one cycle later)

3. In Mealy machines, input change can cause output change as soon as logic is done -

   - asynchronous feedback could cause a big problem when two machines are interconnected

4. Mealy Machines react faster to inputs

   - React in same cycle – don't need to wait for clock 

   - output is affected by noise of input

5. In Moore machines, more logic may be necessary to decode state into outputs  
   
   - more gate delays 

6. small fsm -> binary, gray code; big fsm -> one hot
   
   - one hot uses more register, but low dynamic power consumption 
   
   (only two bits are changed while state changes)

<hr>
<h3> END </h3>
<ul><li> Codes are <em><a href="https://github.com/KuiLiangLin/verilog_FSM/">Here</a></em>. </li></ul>
<ul><li> You can return <em><a href="https://kuilianglin.github.io/Welcome/">My Main Page</a></em>. </li></ul>

