`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Sumanta Kumar Dutta
// 
// Create Date: 11.12.2025 13:03:18
// Design Name: 
// Module Name: clock
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


module clock;
    reg clk, rst;
    wire [5:0] sec, min;
    wire [4:0] hr;
    
    digital_clock dut(clk, rst, sec, min, hr);
    
    initial clk = 1'b0;
    always #5 clk = ~clk;
    
    initial begin
        rst = 1'b1;
        #10 rst = 1'b0;
        #1000 rst = 1'b1;
        #10 $finish;
    end

    initial begin
	$dumpfile ("digclock.vcd");
	$dumpvars (0, clock);
    end
    
endmodule
