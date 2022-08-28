// Copyright (c) 2022 Felix Boehm

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

`timescale 1 ns / 1 ps

`include "axi/typedef.svh"

module PolicyCheck #(
    parameter int unsigned NUM_MEM_REGIONS = 32'd16,
    parameter int unsigned MAX_NUM_MEM_REGIONS = 32'd16,
    parameter int unsigned NUM_DOMAINS = 32'd16,
    parameter int unsigned MAX_NUM_DOMAINS = 32'd16,
    parameter int unsigned ID_WIDTH = 32'd16,
    parameter int unsigned ADDR_WIDTH = 32'd32,

    parameter logic [ADDR_WIDTH-1 : 0]  MEM_REGIONS [0 : NUM_MEM_REGIONS-1]         = '{default: 32'h00000000   },
    parameter int unsigned              MEM_REGION_LSBS [0 : NUM_MEM_REGIONS-1]     = '{default: 32'd0          },
    parameter logic [ID_WIDTH-1 : 0]    DOMAIN_IDS [0 : NUM_DOMAINS-1]              = '{default: 16'h0000       },
    parameter logic [ID_WIDTH-1 : 0]    DOMAIN_MASKS [0 : NUM_DOMAINS-1]            = '{default: 16'hFFFF       }

    // parameter logic [ADDR_WIDTH-1 : 0]  MEM_REGION_0 =      32'h00000000,
    //                                     MEM_REGION_1 =      32'h00000000,
    //                                     MEM_REGION_2 =      32'h00000000,
    //                                     MEM_REGION_3 =      32'h00000000,
    //                                     MEM_REGION_4 =      32'h00000000,
    //                                     MEM_REGION_5 =      32'h00000000,
    //                                     MEM_REGION_6 =      32'h00000000,
    //                                     MEM_REGION_7 =      32'h00000000,
    //                                     MEM_REGION_8 =      32'h00000000,
    //                                     MEM_REGION_9 =      32'h00000000,
    //                                     MEM_REGION_10 =     32'h00000000,
    //                                     MEM_REGION_11 =     32'h00000000,
    //                                     MEM_REGION_12 =     32'h00000000,
    //                                     MEM_REGION_13 =     32'h00000000,
    //                                     MEM_REGION_14 =     32'h00000000,
    //                                     MEM_REGION_15 =     32'h00000000,

    // parameter int unsigned              MEM_REGION_0_LSB =  32'd0,
    //                                     MEM_REGION_1_LSB =  32'd0,
    //                                     MEM_REGION_2_LSB =  32'd0,
    //                                     MEM_REGION_3_LSB =  32'd0,
    //                                     MEM_REGION_4_LSB =  32'd0,
    //                                     MEM_REGION_5_LSB =  32'd0,
    //                                     MEM_REGION_6_LSB =  32'd0,
    //                                     MEM_REGION_7_LSB =  32'd0,
    //                                     MEM_REGION_8_LSB =  32'd0,
    //                                     MEM_REGION_9_LSB =  32'd0,
    //                                     MEM_REGION_10_LSB = 32'd0,
    //                                     MEM_REGION_11_LSB = 32'd0,
    //                                     MEM_REGION_12_LSB = 32'd0,
    //                                     MEM_REGION_13_LSB = 32'd0,
    //                                     MEM_REGION_14_LSB = 32'd0,
    //                                     MEM_REGION_15_LSB = 32'd0,

    // parameter logic [ID_WIDTH-1 : 0]    DOMAIN_0_ID =       16'h0000,
    //                                     DOMAIN_1_ID =       16'h0000,
    //                                     DOMAIN_2_ID =       16'h0000,
    //                                     DOMAIN_3_ID =       16'h0000,
    //                                     DOMAIN_4_ID =       16'h0000,
    //                                     DOMAIN_5_ID =       16'h0000,
    //                                     DOMAIN_6_ID =       16'h0000,
    //                                     DOMAIN_7_ID =       16'h0000,
    //                                     DOMAIN_8_ID =       16'h0000,
    //                                     DOMAIN_9_ID =       16'h0000,
    //                                     DOMAIN_10_ID =      16'h0000,
    //                                     DOMAIN_11_ID =      16'h0000,
    //                                     DOMAIN_12_ID =      16'h0000,
    //                                     DOMAIN_13_ID =      16'h0000,
    //                                     DOMAIN_14_ID =      16'h0000,
    //                                     DOMAIN_15_ID =      16'h0000,

    // parameter logic [ID_WIDTH-1 : 0]    DOMAIN_0_MASK =     16'hFFFF,
    //                                     DOMAIN_1_MASK =     16'hFFFF,
    //                                     DOMAIN_2_MASK =     16'hFFFF,
    //                                     DOMAIN_3_MASK =     16'hFFFF,
    //                                     DOMAIN_4_MASK =     16'hFFFF,
    //                                     DOMAIN_5_MASK =     16'hFFFF,
    //                                     DOMAIN_6_MASK =     16'hFFFF,
    //                                     DOMAIN_7_MASK =     16'hFFFF,
    //                                     DOMAIN_8_MASK =     16'hFFFF,
    //                                     DOMAIN_9_MASK =     16'hFFFF,
    //                                     DOMAIN_10_MASK =    16'hFFFF,
    //                                     DOMAIN_11_MASK =    16'hFFFF,
    //                                     DOMAIN_12_MASK =    16'hFFFF,
    //                                     DOMAIN_13_MASK =    16'hFFFF,
    //                                     DOMAIN_14_MASK =    16'hFFFF,
    //                                     DOMAIN_15_MASK =    16'hFFFF
) (
    input   pu_pkg::policy_entry_t [0 : NUM_MEM_REGIONS-1][NUM_DOMAINS-1 : 0]   POLICY,
    input   logic [ID_WIDTH-1 : 0]                                              ID,
    input   logic [ADDR_WIDTH-1 : 0]                                            ADDR,
    input   axi_pkg::len_t                                                      LEN,
    input   axi_pkg::size_t                                                     SIZE,
    input   logic                                                               READ_WRITE, // 0 -> READ, 1 -> WRITE
    output  logic                                                               GRANTED
);

typedef logic [ID_WIDTH-1 : 0] id_t;
typedef logic [ADDR_WIDTH-1 : 0] addr_t;

// Match memory regions
logic mem_region_matches [0 : NUM_MEM_REGIONS-1];

// localparam addr_t MEM_REGIONS [0 : MAX_NUM_MEM_REGIONS-1] = '{
//     MEM_REGION_0,
//     MEM_REGION_1,
//     MEM_REGION_2,
//     MEM_REGION_3,
//     MEM_REGION_4,
//     MEM_REGION_5,
//     MEM_REGION_6,
//     MEM_REGION_7,
//     MEM_REGION_8,
//     MEM_REGION_9,
//     MEM_REGION_10,
//     MEM_REGION_11,
//     MEM_REGION_12,
//     MEM_REGION_13,
//     MEM_REGION_14,
//     MEM_REGION_15
// };

// localparam int unsigned MEM_REGION_LSBS [0 : MAX_NUM_MEM_REGIONS-1] = '{
//     MEM_REGION_0_LSB,
//     MEM_REGION_1_LSB,
//     MEM_REGION_2_LSB,
//     MEM_REGION_3_LSB,
//     MEM_REGION_4_LSB,
//     MEM_REGION_5_LSB,
//     MEM_REGION_6_LSB,
//     MEM_REGION_7_LSB,
//     MEM_REGION_8_LSB,
//     MEM_REGION_9_LSB,
//     MEM_REGION_10_LSB,
//     MEM_REGION_11_LSB,
//     MEM_REGION_12_LSB,
//     MEM_REGION_13_LSB,
//     MEM_REGION_14_LSB,
//     MEM_REGION_15_LSB
// };

// Last addressed byte
addr_t offset;
addr_t addr_last;

always_comb begin    
    offset = ((LEN + 1) << SIZE) - 1;
    addr_last = ADDR + offset;
end

genvar i;
generate
    for (i = 0; i < NUM_MEM_REGIONS ; i++ ) begin
        if (MEM_REGION_LSBS[i] >= ADDR_WIDTH) begin
            assign mem_region_matches[i] = 1'b1;
        end else begin                
            assign mem_region_matches[i] = 
                // 1. The significant bits match and 
                (MEM_REGIONS[i][ADDR_WIDTH - 1 : MEM_REGION_LSBS[i]] == ADDR[ADDR_WIDTH - 1 : MEM_REGION_LSBS[i]]) &&
                // 2. The offset of the last addressed byte doesn't reach into the significant bits
                (MEM_REGIONS[i][ADDR_WIDTH - 1 : MEM_REGION_LSBS[i]] == addr_last[ADDR_WIDTH - 1 : MEM_REGION_LSBS[i]]);
        end
    end    
endgenerate

// Match domains
logic domain_matches [NUM_DOMAINS-1 : 0];

// localparam id_t DOMAIN_IDS [0 : MAX_NUM_DOMAINS-1] = '{
//     DOMAIN_0_ID,
//     DOMAIN_1_ID,
//     DOMAIN_2_ID,
//     DOMAIN_3_ID,
//     DOMAIN_4_ID,
//     DOMAIN_5_ID,
//     DOMAIN_6_ID,
//     DOMAIN_7_ID,
//     DOMAIN_8_ID,
//     DOMAIN_9_ID,
//     DOMAIN_10_ID,
//     DOMAIN_11_ID,
//     DOMAIN_12_ID,
//     DOMAIN_13_ID,
//     DOMAIN_14_ID,
//     DOMAIN_15_ID
// };

// localparam id_t DOMAIN_MASKS [0 : MAX_NUM_DOMAINS-1] = '{
//     DOMAIN_0_MASK,
//     DOMAIN_1_MASK,
//     DOMAIN_2_MASK,
//     DOMAIN_3_MASK,
//     DOMAIN_4_MASK,
//     DOMAIN_5_MASK,
//     DOMAIN_6_MASK,
//     DOMAIN_7_MASK,
//     DOMAIN_8_MASK,
//     DOMAIN_9_MASK,
//     DOMAIN_10_MASK,
//     DOMAIN_11_MASK,
//     DOMAIN_12_MASK,
//     DOMAIN_13_MASK,
//     DOMAIN_14_MASK,
//     DOMAIN_15_MASK
// };

always_comb begin : match_domains
    automatic bit match;
    domain_matches = '{default: '0};
    foreach (domain_matches[i_domain]) begin
        match = 1'b1;
        for (int i_bit = 0; i_bit < ID_WIDTH; i_bit++) begin
            if (DOMAIN_MASKS[i_domain][i_bit]) begin
                match = match && (DOMAIN_IDS[i_domain][i_bit] == ID[i_bit]);
            end
        end
        if (match) begin
            domain_matches[i_domain] = 1'b1;
        end
    end    
end

always_comb begin : grant_permission
    GRANTED = '0;
    // TODO: Make sure logic actually works as intended
    foreach (mem_region_matches[i]) begin
        foreach (domain_matches[j]) begin
            if (mem_region_matches[i] && domain_matches[j]) begin
                if (
                    (!READ_WRITE && POLICY[i][j].read) || // Read transaction and read permitted
                    (READ_WRITE && POLICY[i][j].write)     // Write transaction and write permitted
                ) 
                    GRANTED = 1'b1;
            end
        end
    end
end

endmodule