`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Sumanta Kumar Dutta
// 
// Create Date: 26.01.2026 22:57:03
// Design Name: 4:2 Priority Encoder
// Module Name: priority_encoder
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


module priority_encoder(
    input [3:0] data_in,
    output reg [1:0] y_out
    );
    
    always @(data_in) begin
        if(data_in[3])
            y_out = 2'd3;
        else if(data_in[2])
            y_out = 2'd2;
        else if(data_in[1])
            y_out = 2'd1;
        else if(data_in[0])
            y_out = 2'd0;
        else
            y_out = 2'd0;
    end
endmodule

