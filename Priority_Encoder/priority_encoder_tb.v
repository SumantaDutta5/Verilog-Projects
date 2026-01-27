`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Sumanta Kumar Dutta
// 
// Create Date: 26.01.2026 23:01:35
// Design Name: 4:2 Priority Encoder Testbench
// Module Name: priority_encoder_tb
// Project Name: priority_encoder
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


module priority_encoder_tb();
    reg [3:0] data_in;
    wire [1:0] y_out;

    priority_encoder dut(.data_in(data_in),.y_out(y_out));
    
    initial begin
        #10
        data_in = 4'b1000;
        #100
        data_in = 4'b0101;
        #100
        data_in = 4'b001;
        #100
        $finish;
    end

    initial begin
	$dumpfile("priority.vcd");
	$dumpvars(0, priority_encoder_tb);
    end

endmodule
