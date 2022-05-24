onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/clk
add wave -noupdate /test/SCLK
add wave -noupdate /test/slaveSelect
add wave -noupdate /test/CS
add wave -noupdate /test/start
add wave -noupdate /test/reset
add wave -noupdate /test/masterDataReceived
add wave -noupdate /test/masterDataToSend
add wave -noupdate /test/slaveDataReceived
add wave -noupdate /test/slaveDataToSend
add wave -noupdate /test/MOSI_0
add wave -noupdate -color {Medium Violet Red} /test/MOSI_1
add wave -noupdate -color {Medium Violet Red} /test/MOSI_2
add wave -noupdate -color {Medium Violet Red} /test/MISO_3
add wave -noupdate -color {Cornflower Blue} /test/MISO_0
add wave -noupdate -color {Cornflower Blue} /test/MISO_1
add wave -noupdate -color {Cornflower Blue} /test/MISO_2
add wave -noupdate -color {Cornflower Blue} /test/MOSI_3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1707 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 175
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
WaveRestoreZoom {0 ps} {28373 ps}
