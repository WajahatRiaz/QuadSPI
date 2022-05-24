module Master (
input 	logic clk, reset, start,
input 	logic slaveSelect,
input 	logic [7:0] masterDataToSend,
output	logic [7:0] masterDataReceived,
output  logic sclk,
output  logic CS,

output  logic MOSI_0,
output  logic MOSI_1,
output  logic MOSI_2,
output  logic MOSI_3,

input 	logic MISO_0,
input	logic MISO_1,
input 	logic MISO_2,
input 	logic MISO_3);

reg [7:0] Register; // Master shift register

assign sclk = clk; // sclk to be sent to external flash memory

reg transmit = 0; // To allow transmitting of bits

integer maxCount = 0; // Counter that indicates transfer is complete when max is reached i.e. 5

always @(posedge start or posedge reset) begin // Reset - Start
if (!transmit && start) begin
	Register <= masterDataToSend; // Initialize shift register
	masterDataReceived <= 8'bxxxxxxxx; // Initialize data received with dont cares
	maxCount <= 0; // Initial value of count
	transmit <= 1; // Allow transmission between master & slave
	
	if (slaveSelect == 0) begin
		CS <= 1'b0; // slave selected
	end
	
	else begin
		CS <= 1'b1; // No slave selected
	end
end

if (reset) begin
	Register <= 0; // Reset the register to zero
	end
end

always @(posedge clk) begin // Shifting
if (transmit) begin
	Register <= Register >> 4; // Shift 4 times 
	MOSI_0 <= Register[0]; // Write to MOSI 0
	MOSI_1 <= Register[1]; // Write to MOSI 1
	MOSI_2 <= Register[2]; // Write to MOSI 2
	MOSI_3 <= Register[3]; // Write to MOSI 3

	end
end

always @(negedge clk) begin // Sampling
	if (maxCount >= 5) begin // Max count reached (All bits transferred)
	transmit <= 0; // Disallow transmission
	CS <= 1'b1; // Unselect slave
	end

if (transmit) begin
	Register[7] <= MISO_0; // Read from MISO 0
	Register[6] <= MISO_1; // Read from MISO 1
	Register[5] <= MISO_2; // Read from MISO 2
	Register[4] <= MISO_3; // Read from MISO 3

	masterDataReceived <= {MISO_3,MISO_2,MISO_1,MISO_0, masterDataReceived[7:4]}; // Update Data Received from slave
	maxCount <= maxCount + 1; // Increment counter
	end
end
endmodule
