`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Sumanta Kumar Dutta
// 
// Create Date: 13.09.2025 12:34:46
// Design Name: FSM-based Sequence Detector
// Module Name: fsm_sequence
// Project Name: fsm_sequence
// Target Devices: 
// Tool Versions: 
// Description: 110101
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fsm_sequence(x,clk,reset,z);
input x,clk,reset;
output reg z;

parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5;
reg [2:0] ps,ns;

always @(posedge clk or posedge reset)
    if (reset) ps <= S0;
    else ps <= ns;

always @(ps,x) begin
    z = 0;
    case (ps)
        S0: ns = x ? S1 : S0;
        S1: ns = x ? S2 : S0;
        S2: ns = x ? S2 : S3;
        S3: ns = x ? S4 : S0;
        S4: ns = x ? S2 : S5;
        S5: begin
            z = x ? 1 : 0;
            ns = x ? S1 : S0;
        end
        
        default: ns = S0;

    endcase
end

endmodule

