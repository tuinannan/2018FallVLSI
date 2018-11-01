
This time I added the precharge circuit block and SA block with enable signal to the dram.
In this code I still use the one-bitline case to simplify the code.
all the inpur signal's format corresponds to the process of realizing NOT logic function in ambit.
The first 30ns is used to charge C0;30-60ns is used to charge C1;60-90ns is used to charge C2;100-110ns is used to activate transitors and get the AND-OR result.
By changing the initial status of C1, we can get the corresponding AND-OR result.
