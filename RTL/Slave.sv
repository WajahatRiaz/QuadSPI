module Slave(
input 	logic reset,
input	logic [7:0] slaveDataToSend, 
output  logic [7:0] slaveDataReceived,
input	logic sclk,
input	logic CS,
input	logic MOSI_0,
input 	logic MOSI_1,
input 	logic MOSI_2,
input 	logic MOSI_3,
output  logic MISO_0,
output  logic MISO_1,
output  logic MISO_2,
output  logic MISO_3);

reg [7:0] Register; // Slave shift register

reg flag = 0; // Boolean: To allow transmitting of bits

always @(negedge CS or posedge reset) begin
if (CS == 0) begin
	Register <= slaveDataToSend; // Initialize shift register
	slaveDataReceived <= 8'bxxxxxxxx; // Initialize data received with dont cares
	flag <= 1; // Set flag to 1
	end
if (reset) begin
	Register <= 0; // Reset shift register
	end
end

always @(posedge CS) begin // When slave is unselected
	flag <= 0; // Disallow transmission by setting flag to 0
	MISO_0 <= 1'bz; // Disconnect MISO 0 from this slave
	MISO_1 <= 1'bz; // Disconnect MISO 1 from this slave
	MISO_2 <= 1'bz; // Disconnect MISO 2 from this slave
	MISO_3 <= 1'bz; // Disconnect MISO 3 from this slave

end

always @(posedge sclk) begin// Shifting
if (flag) begin
	Register <= Register<<4; // Shift
	MISO_0<= Register[4]; // Write to MISO 0
	MISO_1<= Register[5]; // Write to MISO 1
	MISO_2<= Register[6]; // Write to MISO 2
	MISO_3<= Register[7]; // Write to MISO 3
	end
end

always @ (negedge sclk) begin// Sampling
if (flag) begin
	Register[0] = MOSI_0; // Read from MOSI 0
	Register[1] = MOSI_1; // Read from MOSI 1
	Register[2] = MOSI_2; // Read from MOSI 2
	Register[3] = MOSI_3; // Read from MOSI 3

	slaveDataReceived <= {slaveDataReceived[3:0],MOSI_3,MOSI_2,MOSI_1,MOSI_0}; // Update Data received from master
	end
end

endmodule
