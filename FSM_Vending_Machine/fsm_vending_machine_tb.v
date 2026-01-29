`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Sumanta Kumar Dutta
// 
// Create Date: 28.01.2026 19:52:48
// Design Name: FSM Vending Machine Testbench
// Module Name: fsm_vending_machine_tb
// Project Name: fsm_vending_machines
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fsm_vending_machine_tb;
reg clk;
reg rst;
reg[1:0] coin;

wire out;
wire change;

fsm_vending_machine dut(.clk(clk),.rst(rst),.coin(coin),.out(out),.change(change));

always #5 clk = ~clk;  //Clock Generation

initial begin
    rst = 1;
    clk = 0; #6
    
    rst = 0;
    //Adding 3 Rs.5 coins one-by-one
    coin = 2'b01;   #11
    coin = 2'b01;   #16
    coin = 2'b01;   #25
    //Waveform: 5_5_5.png
    
    //Adding a Rs.5 coin and then a Rs.10 coin
    //coin = 2'b01;   #11
    //coin = 2'b10;   #16
    //Waveform: 5_10.png
  
    //Adding 2 Rs.10 coins one-by-one
    //coin = 2'b10;   #11
    //coin = 2'b10;   #16
    //Waveform: 10_10.png

    $finish;
end

initial begin
    $dumpfile("machine.vcd");
    $dumpvars(0, fsm_vending_machine_tb);
end

endmodule
