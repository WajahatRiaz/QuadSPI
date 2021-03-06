
The protocol was implemented on QuestaSim using SystemVerilog. Two modules were made i.e., a master and a slave. A simplified testbench was implemented and the waveforms related to that are given below:

![image](https://user-images.githubusercontent.com/61377755/170163040-93bbb1b6-dbf2-4814-ae74-8d1fee096b06.png)

Initially, the data we want to send to the slave from the master is 8’hAB stored in masterDataToSend. Therefore, on the clock edge SCLK the most significant nibble 4’hA = 4’b1010 is being pushed onto the MOSI_x lines. The corresponding values with respect to vertical line is given in the figure below:

![image](https://user-images.githubusercontent.com/61377755/170163123-8cf1da7c-0d22-4700-8316-c00723eeb41a.png)

Similarly, the data we want to send to the master from the slave is 8’hDE stored in slaveDataToSend. On the clock edge SCLK, the most significant nibble 4’hD=4’b1101 is being pushed onto the MISO_x lines. We know that initially, we want to send 8’hAB from master to slave, and similarly, we want to send 8’hDE from slave to the master. You can see in the figures below that the received data in both slave and master are an exact match of the data we sent. Once the communication happens the chip select signal CS is set to high which disconnects the slave from the master and introduces dummy values. This phenomenon can be viewed as blue lines present on the slave MISO_x lines given below: 


