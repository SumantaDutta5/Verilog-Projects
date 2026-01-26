`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.09.2025 21:19:53
// Design Name: 
// Module Name: test_sequence
// Project Name: 
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


module test_sequence;
reg x,clk,reset;
wire z;

fsm_sequence dut (.x(x),.clk(clk),.reset(reset),.z(z));

always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;
    x = 0;
    
    #10 reset = 0;
    
    #10 x = 1; #10 x = 1; #10 x = 0; #10 x = 1; #10 x = 0; #10 x = 1;
    #10 x = 1; #10 x = 0; #10 x = 1; #10 x = 0; #10 x = 1; #10 x = 1;
    #20 $finish;
end

initial begin
    $dumpfile ("sequence.vcd");
    $dumpvars (0, test_sequence);
end
    
endmodule
