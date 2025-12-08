module TLC_tb;

reg clk;
wire [2:0] light;

TLC dut (clk,light);

always #5 clk = ~clk;

initial
begin
	clk = 1'b0;
	#100 $finish;
end

initial
begin
	$dumpfile ("traffic.vcd");
	$dumpvars (0, TLC_tb);
	$monitor ($time, "RGY: %b", light);
end
endmodule

