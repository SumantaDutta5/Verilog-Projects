`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Sumanta Kumar Dutta
// 
// Create Date: 05.08.2025 14:15:42
// Design Name: 4-bit Booth Multiplier testbench
// Module Name: booth_multiplier_tb
// Project Name: booth_multiplier
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


module booth_multiplier_tb;

  reg signed [3:0] A, B;
  wire signed [7:0] P;

  booth_multiplier dut (.A(A),.B(B),.P(P));

  initial begin
    A = 4'b0100; B = 4'b0101;
    #100
    A = 4'b0010; B = 4'b1101;
    #100
    A = 4'b1000; B = 4'b0111;
    #100
    A = 4'b1010; B = 4'b1011;
    #100
    $finish;
  end

  initial begin
    $dumpfile("booth.vcd");
    $dumpvars(0, booth_multiplier_tb);
  end

endmodule
