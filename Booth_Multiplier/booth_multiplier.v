`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Sumanta Kumar Dutta
// 
// Create Date: 05.08.2025 14:12:19
// Design Name: Booth Multiplier
// Module Name: booth_multiplier
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


module booth_multiplier (
  input  signed [3:0] A,   
  input  signed [3:0] B,   
  output signed [7:0] P
);

  reg signed [4:0] A_reg;
  reg signed [4:0] Q;
  reg signed [4:0] M;
  reg Q_1;

  reg signed [9:0] booth_result;

  integer i;

  always @(*) begin
    A_reg = 0;
    Q = {B[3],B};   
    M = {A[3],A};   
    Q_1 = 0;

    for (i = 0; i < 4; i = i + 1) begin
      case ({Q[0], Q_1})
        2'b01: A_reg = A_reg + M;
        2'b10: A_reg = A_reg - M;
        default: ;
      endcase

      {A_reg,Q,Q_1} = {A_reg[4],A_reg,Q,Q_1} >>> 1;
    end
    
    booth_result = {A_reg,Q[4:1]};
  end

  assign P = booth_result[7:0];

endmodule
