# GSOC-Realtime-Focus-Peaking
The VHDL kernel implements Realtime focus peaking algorithm on a stream if incoming pixels \n
(1) GSOC_18_rahul_vyas.pdf gives a detailed description of the project \n
(2) kernel_top.vhd is the top level module of the focus peaking module
(3) line_buffer_one_two.vhd is the vhdl entity for line buffer module
(4) line_buffer_test.vhd is the test bench for line buffer module
(5) sobel_kernel.vhd is the arithematic unit of the peaking module
(6) sobel_test.vhd is the test bench for the sobel_kernel
(7) top_kernel_tb.vhd is the test bech for the top level module
