onerror {resume}
quietly WaveActivateNextPane {} 0
restart -force
delete wave *
add wave -noupdate -radix hexadecimal /testbench/S
add wave -noupdate /testbench/Clk
add wave -noupdate /testbench/Reset
add wave -noupdate /testbench/Run
add wave -noupdate /testbench/Continue
add wave -noupdate /testbench/LED
add wave -noupdate /testbench/HEX0
add wave -noupdate /testbench/HEX1
add wave -noupdate /testbench/HEX2
add wave -noupdate /testbench/HEX3
add wave -noupdate /testbench/HEX4
add wave -noupdate /testbench/HEX5
add wave -noupdate /testbench/HEX6
add wave -noupdate /testbench/HEX7
add wave -noupdate /testbench/CE
add wave -noupdate /testbench/UB
add wave -noupdate /testbench/LB
add wave -noupdate /testbench/OE
add wave -noupdate /testbench/WE
add wave -noupdate -radix hexadecimal /testbench/ADDR
add wave -noupdate -radix hexadecimal /testbench/Data
add wave -noupdate -radix hexadecimal /testbench/lab6/my_slc/d0/MAR
add wave -noupdate -radix hexadecimal /testbench/lab6/my_slc/d0/MDR
add wave -noupdate -radix hexadecimal /testbench/lab6/my_slc/d0/IR
add wave -noupdate -radix hexadecimal /testbench/lab6/my_slc/d0/PC
add wave -noupdate -radix hexadecimal /testbench/lab6/my_slc/d0/PC_Plus_1
add wave -noupdate -radix hexadecimal /testbench/lab6/my_slc/d0/PC_Plus_1_Synced
add wave -noupdate -radix hexadecimal /testbench/lab6/my_slc/d0/Bus
add wave -noupdate -radix hexadecimal /testbench/lab6/my_slc/d0/REG_NZP_Out
add wave -noupdate -radix hexadecimal /testbench/lab6/my_slc/d0/LD_BEN
add wave -noupdate -radix hexadecimal /testbench/lab6/my_slc/d0/LD_CC
add wave -noupdate -radix hexadecimal /testbench/lab6/my_slc/d0/test
add wave -noupdate -radix hexadecimal /testbench/lab6/my_slc/state_controller/BEN
add wave -noupdate -radix hexadecimal /testbench/lab6/my_slc/state_controller/State
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 358
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {800 ns}
run 4200ns