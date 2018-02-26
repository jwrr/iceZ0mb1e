//
// iceZ0mb1e - FPGA 8-Bit TV80 SoC for Lattice iCE40
// with complete open-source toolchain flow using yosys and SDCC
//
// Copyright (c) 2018 Franz Neumann (netinside2000@gmx.de)
//
// Permission is hereby granted, free of charge, to any person obtaining a 
// copy of this software and associated documentation files (the "Software"), 
// to deal in the Software without restriction, including without limitation 
// the rights to use, copy, modify, merge, publish, distribute, sublicense, 
// and/or sell copies of the Software, and to permit persons to whom the 
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included 
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
// CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

module membram #(
    parameter ADDR_WIDTH = 15,
	parameter MEM_HEX = "",
	parameter MEM_INIT = 0
) (
    wr_clk,
    data_in,
    wr_cs,
    addr,
    data_out,
    rd_cs
);
    input wr_clk;
    input[7:0] data_in;
    input wr_cs;
    input[ADDR_WIDTH-1:0] addr;
    inout[7:0] data_out;
    input rd_cs;

    assign data_out = (rd_cs) ? mem_8[addr] : 8'bz;

    reg [7:0] mem_8 [0:(1 << ADDR_WIDTH)-1];
    integer j;
    initial begin
        if( MEM_INIT > 0 ) begin
            $readmemh(MEM_HEX, mem_8);
        end
        // else begin
        //     for(j = 0; j < (1 << ADDR_WIDTH); j = j+1)
        //         mem_8[j] = 8'hFF;
        // end
    end

    always @(posedge wr_clk)
    begin
        if (wr_cs) begin
            mem_8[addr] <= data_in;
        end
    end

endmodule
