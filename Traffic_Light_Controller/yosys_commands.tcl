#This TCL script automates the process of RTL Synthesis using Yosys

#Step-1: Reading the Verilog file of our RTL design
read_verilog TLC.v

#Step-2: RTL Synthesis by specifying the top module within the Verilog file
synth -top TLC

#Step-3: Show the netlist after RTL Synthesis
show
